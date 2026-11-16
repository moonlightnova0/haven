extends PanelContainer

var row: int
var col: int


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$Yellow.visible = false
	$Green.visible = false
	$Grey.visible = false

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	$Letter.text = Global.letters[row][col].to_upper()
	
func _on_guess(r, result):
	if r != row:
		pass
	elif result[col] == 'x':
		$Grey.visible = true
	elif result[col] == 'g':
		$Green.visible = true
	else:
		$Yellow.visible = true
		
