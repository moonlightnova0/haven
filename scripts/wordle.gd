extends Node2D

var row = 0
var col = 0
var guesses = 0
var valid_words = []

signal guessed(row, result)

# edit this
var ans = 'right'
	

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	Global.letters = []

	%WinPopup.hide()
	
	draw_tiles()
	
	# make list of valid words
	var file = FileAccess.open('valid-wordle-words.txt', FileAccess.READ)
	while not file.eof_reached():
		var line = file.get_line()
		valid_words.append(line)
		
	# reset board [can't multiply arrays + no list comprehensions?]
	for r in range(6):
		var row = [' ', ' ', ' ', ' ', ' ']
		Global.letters.append(row)
		
	if Global.wordle_cleared: ans = valid_words.pick_random()
	print(ans)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
	
func _input(event):
	if event is InputEventKey and event.pressed and not event.echo and event.keycode:
		if event.keycode == KEY_BACKSPACE:
			if col >= 1: col -= 1
			Global.letters[row][col] = ' '
		elif event.keycode == KEY_ENTER:
			if col == 5:
				var guess = ''.join(Global.letters[row])
				if guess not in valid_words: return
				var result = check_guess(guess, ans)
				guessed.emit(row, result)
				if result == 'ggggg':
					# win: +1 update
					if not Global.wordle_cleared:
						Global.updates += 1
						Global.wordle_cleared = true
					%WinPopup.popup_centered()
				else:
					row += 1
					col = 0
					if row >= 6:
						pass # lose
						# kicked out?
					print(row)
		elif col <= 4 and ((event.unicode >= 65 and event.unicode <= 90) or (event.unicode >= 97 and event.unicode <= 122)):
			Global.letters[row][col] = char(event.unicode)
			col += 1
		
	
func draw_tiles():
	const TILE = preload("res://scenes/letter_tile.tscn")
	const GAP = 80.0
	var y = -3 * GAP - 30

	for row in range(6):
		var x = -2 * GAP - 30
		for col in range(5):
			var new_tile = TILE.instantiate()
			
			new_tile.position = Vector2(x, y)
			new_tile.row = row
			new_tile.col = col
			
			guessed.connect(new_tile._on_guess) # connect guess signal
			
			add_child(new_tile)
			x += GAP
		y += GAP
		
func check_guess(guess, ans):
	var result = ['x', 'x', 'x', 'x', 'x']
	var seen = {}	
	
	var letters = {}
	var greens = [false, false, false, false, false]
	# no collections.Counter lol (but .get works exactly like python)	
	for c in ans:
		letters[c] = 1 + letters.get(c, 0)

	for i in range(5):
		var ch = guess[i]
		if ch == ans[i]:
			result[i] = 'g'
			letters[ch] -= 1
			greens[i] = true

	for i in range(5):
		if greens[i]: continue
		var ch = guess[i]
		if ch in letters and letters[ch] > 0:
			result[i] = 'y'
			letters[ch] -= 1
			
	return ''.join(result)
	
