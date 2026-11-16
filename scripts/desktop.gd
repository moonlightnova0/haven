extends Node2D

const dates = [["04", "18", "2393"], ["01", "30", "2086"], ["11", "15", "2026"]]

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	%DateChanged.visible = false
	$WordleButton.visible = false
	if Global.started:
		%DateLabel.text = "%s/%s/%s" % Global.current_date
		$PlayButton.visible = false
		if Global.date_index >= 1: $WordleButton.visible = true
	else:
		$PongButton.visible = false
		$Taskbar.visible = false
		


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_wordle_button_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/wordle.tscn")


func _on_pong_button_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/pong_scene.tscn")


func _on_play_button_pressed() -> void:
	$PlayButton.visible = false
	$PongButton.visible = true
	$Taskbar.visible = true
	if Global.date_index >= 1: $WordleButton.visible = true
	Global.started = true


func _on_update() -> void:
	if Global.updates < 1:
		%NoUpdates.popup_centered()
		return
	%DateChanged.popup_centered()


func _on_submit_button_pressed() -> void:
	%DateChanged.hide()
	if %Password.text in Global.passwords:
		Global.passwords.erase(%Password.text)
		Global.updates -= 1
		Global.date_index += 1
		Global.current_date = dates[Global.date_index]
		if Global.date_index == 2:
			get_tree().change_scene_to_file("res://scenes/outro.tscn")
		_ready()
	else:
		%InvalidPassword.popup_centered()
