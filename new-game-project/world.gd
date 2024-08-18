extends Node2D

var has_falling_block : bool = false
var active_block
var spawn_area_contents = []

@onready var block_spawner: Marker2D = $blockSpawner
@onready var block_manager: Node2D = $blockManager
@onready var piece = preload("res://scenes/piece.tscn")
@onready var spawn_area: Area2D = $spawnArea

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if !has_falling_block and spawn_area_contents.size() <= 0:
		has_falling_block = true
		var new_block = piece.instantiate()
		new_block.global_position = block_spawner.global_position
		block_manager.add_child(new_block)
		active_block = new_block
		active_block.piece_placed.connect(_on_piece_placed)
	

func _on_piece_placed():
	has_falling_block = false
	active_block = null

#func _on_spawn_timer_timeout() -> void:
	#print("timer hit")
	#var new_block = piece.instantiate()
	#new_block.global_position = block_spawner.global_position
	#block_manager.add_child(new_block)
	#print(new_block.global_position)


func _on_spawn_area_body_entered(body: Node2D) -> void:
	spawn_area_contents.append(body)



func _on_spawn_area_body_exited(body: Node2D) -> void:
	spawn_area_contents.erase(body)
