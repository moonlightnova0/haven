extends Node

var letters = []
var current_date = ["04","18","2393"]
var started = false
var updates = 0
var passwords = ['potato chips','sea bunny']
var date_index = 0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	# can't multiply arrays + no list comprehensions?
	for r in range(6):
		var row = [' ', ' ', ' ', ' ', ' ']
		letters.append(row)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
