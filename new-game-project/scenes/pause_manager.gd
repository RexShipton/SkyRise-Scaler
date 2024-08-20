extends Control

@onready var switch_sound: AudioStreamPlayer = $SwitchSound
@onready var click_sound: AudioStreamPlayer = $ClickSound
@onready var unpause_button: Button = $Center/Panel/MarginContainer/VBoxContainer/UnpauseButton
@onready var quit_button: Button = $Center/Panel/MarginContainer/VBoxContainer/QuitButton

func _ready() -> void:
	visible = false

func _process(_delta: float) -> void:
	if Input.is_action_just_pressed("ui_cancel"):
		toggle_pause()

func toggle_pause() -> void:
	visible = !visible
	get_tree().paused = true if visible else false

func _on_unpause_button_pressed() -> void:
	toggle_pause()

func _on_quit_button_pressed() -> void:
	get_tree().paused = false
	get_tree().change_scene_to_file("res://scenes/main_menu.tscn")

func play_switch_sound() -> void:
	switch_sound.play()

func play_click_sound() -> void:
	click_sound.play()

func _on_unpause_button_mouse_entered() -> void:
	unpause_button.grab_focus()

func _on_quit_button_mouse_entered() -> void:
	quit_button.grab_focus()
