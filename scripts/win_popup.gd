extends Window


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	%NewDateLabel.text = "You have %s update(s) available!" % (Global.updates)


func _on_close() -> void:
	hide()
	get_tree().change_scene_to_file("res://scenes/desktop.tscn")
