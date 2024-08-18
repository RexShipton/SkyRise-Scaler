extends CanvasLayer

@onready var score_label: Label = $TopRight/Panel/MarginContainer/VBoxContainer/HBoxContainer2/ScoreLabel
@onready var game_over_score_label: Label = $Center/GameOverPanel/MarginContainer/VBoxContainer/HBoxContainer/GameOverScoreLabel
@onready var game_over_panel: Panel = $Center/GameOverPanel
var SCORE_RESOURCE = preload("res://ScoreResource.tres")

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass

func update_score(value : float) -> void:
	var score_text = str(SCORE_RESOURCE.score) + " feet!"
	score_label.text = score_text
	game_over_score_label.text = score_text

func update_tile(_tile : int) -> void:
	# This would be dependent on some stuff.
	pass

func game_over() -> void:
	game_over_panel.visible = true

func _on_game_over_main_menu_button_pressed() -> void:
	get_tree().paused = false
	get_tree().change_scene_to_file("res://scenes/main_menu.tscn")
