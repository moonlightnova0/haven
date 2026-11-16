extends Node2D

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var screen_center = get_viewport_rect().size / 2
	
	$Paddle.position.y = screen_center.y
	$Ball.position = screen_center
	%WinPopup.hide()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	var screen_center = get_viewport_rect().size / 2
	const CENTER_DIST = 400
	
	$Paddle.position.x = screen_center.x + CENTER_DIST
	
	for body in $WinDetector.get_overlapping_bodies():
		if body.name == "Ball" or Input.is_action_just_pressed("debug_win"):
			# win: +1 update
			if not Global.pong_cleared:
				Global.updates += 1
				Global.pong_cleared = true
			%WinPopup.popup_centered()

			
			

	
