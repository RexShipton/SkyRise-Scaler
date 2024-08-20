extends Node2D

signal piece_placed(node : Node)
signal game_over
signal next_piece_picked(tex : Texture)

var active : bool = true
var has_falling_block : bool = false
var active_block
var spawn_area_contents = []
var next_piece

@onready var block_spawner: Marker2D = $blockSpawner
@onready var block_manager: Node2D = $blockManager
@onready var piece = preload("res://scenes/pieces/piece.tscn")
@onready var spawn_area: Area2D = $spawnArea
@onready var PIECE_3 = preload("res://scenes/pieces/piece3.tscn")
@onready var PIECE_S = preload("res://scenes/pieces/pieceS.tscn")
@onready var PIECE_BLOCK = preload("res://scenes/pieces/piece_block.tscn")
@onready var PIECE_TUNNEL = preload("res://scenes/pieces/piece_tunnel.tscn")
@onready var item_manager: Node2D = $itemManager
@onready var sub_viewport: SubViewport = $SubViewport

@onready var pieces = [
	preload("res://scenes/pieces/piece.tscn"),
	preload("res://scenes/pieces/piece3.tscn"),
	preload("res://scenes/pieces/pieceS.tscn"),
	preload("res://scenes/pieces/piece_block.tscn"),
	preload("res://scenes/pieces/piece_tunnel.tscn"),
]

@onready var piece_placed_sound: AudioStreamPlayer = $PiecePlacedSound

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	next_piece = get_random_piece(pieces).instantiate()
	next_piece.isPlaced = true
	sub_viewport.add_child(next_piece)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	if !active: return
	
	if !has_falling_block and spawn_area_contents.size() <= 0:
		has_falling_block = true
		var new_block = next_piece
		new_block.isPlaced = false
		new_block.reparent(block_manager)
		new_block.global_position = block_spawner.global_position
		new_block.spawn_items()
		#block_manager.add_child(new_block)
		active_block = new_block
		active_block.piece_placed.connect(_on_piece_placed)
		
		next_piece = get_random_piece(pieces).instantiate()
		next_piece.isPlaced = true
		sub_viewport.add_child(next_piece)
		next_piece.global_position = Vector2(sub_viewport.size.x / 2, sub_viewport.size.y / 2)
		next_piece_picked.emit(sub_viewport.get_texture())


func add_item_to_world(body):
	item_manager.add_child(body)

func _on_piece_placed():
	piece_placed_sound.play()
	piece_placed.emit(active_block)
	has_falling_block = false
	active_block = null



#func _on_spawn_timer_timeout() -> void:
	#print("timer hit")
	#var new_block = piece.instantiate()
	#new_block.global_position = block_spawner.global_position
	#block_manager.add_child(new_block)
	#print(new_block.global_position)

func get_random_piece(piece_list: Array):
	if piece_list.is_empty():
		print("piece array is zero and it should never be zero")
		return
	return piece_list[randi() % piece_list.size()]

func _on_spawn_area_body_entered(body: Node2D) -> void:
	spawn_area_contents.append(body)

func _on_spawn_area_body_exited(body: Node2D) -> void:
	spawn_area_contents.erase(body)

func _on_player_die() -> void:
	active = false
	game_over.emit()
