extends CanvasLayer

@onready var high_score_label: Label = $Top/Panel/MarginContainer/Control/HBoxContainer/HighScoreLabel

func _ready() -> void:
	high_score_label.text = str(ScoreManager.scoreResource.highScore) + " feet!"

func _on_play_button_pressed() -> void:
	ScoreManager.scoreResource.score = 0
	get_tree().change_scene_to_file("res://world.tscn")

func _on_quit_button_pressed() -> void:
	get_tree().quit()
