extends CanvasLayer

@onready var high_score_label: Label = $Top/Panel/MarginContainer/Control/HBoxContainer/HighScoreLabel
@onready var switch_sound: AudioStreamPlayer = $SwitchSound
@onready var click_sound: AudioStreamPlayer = $ClickSound
@onready var play_button: Button = $Center/Panel/MarginContainer/VBoxContainer/PlayButton
@onready var quit_button: Button = $Center/Panel/MarginContainer/VBoxContainer/QuitButton

func _ready() -> void:
	get_tree().paused = false
	high_score_label.text = str(ScoreManager.scoreResource.highScore) + " feet!"

func _on_play_button_pressed() -> void:
	ScoreManager.scoreResource.score = 0
	get_tree().change_scene_to_file("res://world.tscn")

func _on_quit_button_pressed() -> void:
	get_tree().quit()

func play_switch_sound() -> void:
	switch_sound.play()

func play_click_sound() -> void:
	click_sound.play()

func _on_play_button_mouse_entered() -> void:
	play_button.grab_focus()

func _on_quit_button_mouse_entered() -> void:
	quit_button.grab_focus()
