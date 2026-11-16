extends CharacterBody2D


const SPEED = 500.0

func _ready() -> void:
	var direction = Vector2(randi_range(1, 13), 5).normalized()
	position = get_viewport_rect().size / 2
	velocity = SPEED * direction
	get_tree().paused = false

func _physics_process(delta: float) -> void:
	var screen_size = get_viewport_rect().size	
	var collision = move_and_collide(velocity * delta)
	if collision:
		velocity = velocity.bounce(collision.get_normal())
		
	if position.x > screen_size.x:
		%Respawn.start()
		get_tree().paused = true
		
