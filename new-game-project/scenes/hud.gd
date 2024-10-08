extends CanvasLayer

@onready var score_label: Label = $TopRight/MarginContainer/Panel/MarginContainer/VBoxContainer/HBoxContainer2/ScoreLabel
@onready var game_over_score_label: Label = $Center/GameOverPanel/MarginContainer/VBoxContainer/HBoxContainer/GameOverScoreLabel
@onready var game_over_panel: Panel = $Center/GameOverPanel
@onready var switch_sound: AudioStreamPlayer = $SwitchSound
@onready var click_sound: AudioStreamPlayer = $ClickSound
@onready var game_over_main_menu_button: Button = $Center/GameOverPanel/MarginContainer/VBoxContainer/GameOverMainMenuButton
@onready var next_tile_texture: TextureRect = $TopRight/MarginContainer/Panel/MarginContainer/VBoxContainer/HBoxContainer/NextTileHolder/TextureRect
@onready var level_label: Label = $TopRight/MarginContainer/Panel/MarginContainer/VBoxContainer/HBoxContainer3/LevelLabel
@onready var rich_level_text_label: RichTextLabel = $LevelAnimator/Panel/MarginContainer/VBoxContainer/RichLevelTextLabel
@onready var level_animation_player: AnimationPlayer = $LevelAnimator/LevelAnimationPlayer

const defaultRichTextString : String = "[wave amp=40.0 freq=5.0][i][center][rainbow]Now Entering Level "

func _ready() -> void:
	update_score()
	ScoreManager.scoreResource.changed.connect(update_score)

func update_score() -> void:
	var score_text = str(ScoreManager.scoreResource.score) + " feet!"
	score_label.text = score_text
	game_over_score_label.text = score_text

func update_tile(tileTexture : Texture) -> void:
	next_tile_texture.texture = tileTexture

func update_level(level : int) -> void:
	level_label.text = str(level) + "!"
	rich_level_text_label.text = defaultRichTextString + str(level) + "!"
	level_animation_player.stop()
	level_animation_player.play("play")

func game_over() -> void:
	game_over_panel.visible = true

func _on_game_over_main_menu_button_pressed() -> void:
	get_tree().paused = false
	play_click_sound()
	get_tree().change_scene_to_file("res://scenes/main_menu.tscn")

func play_switch_sound() -> void:
	switch_sound.play()

func play_click_sound() -> void:
	click_sound.play()

func _on_game_over_main_menu_button_mouse_entered() -> void:
	game_over_main_menu_button.grab_focus()
