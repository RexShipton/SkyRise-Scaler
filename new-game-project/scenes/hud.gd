extends CanvasLayer

@onready var score_label: Label = $TopRight/Panel/VBoxContainer/HBoxContainer2/ScoreLabel

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func update_score(value : float) -> void:
	score_label.text = str(value) + " feet!"

func update_tile(tile : int) -> void:
	# This would be dependent on some stuff.
	pass
