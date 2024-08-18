extends CanvasLayer

@onready var high_score_label: Label = $Top/Panel/MarginContainer/HBoxContainer/HighScoreLabel
var SCORE_RESOURCE = preload("res://ScoreResource.tres")

func _ready() -> void:
	high_score_label.text = str(SCORE_RESOURCE.score) + " feet!"

func _on_play_button_pressed() -> void:
	get_tree().change_scene_to_file("res://world.tscn")

func _on_quit_button_pressed() -> void:
	get_tree().quit()
