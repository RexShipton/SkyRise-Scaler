extends Control

@onready var objectScene = preload("res://scenes/falling_object.tscn")
@onready var object_holder: Node2D = $ObjectHolder
@onready var spawn_timer: Timer = $SpawnTimer

var objectList : Array
var spawnIndex : int = 0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	for i in 20:
		var temp : Node = objectScene.instantiate()
		object_holder.add_child(temp)
		temp.global_position = Vector2(-1000, -1000)
		objectList.append(temp)
	
	spawn_timer.start()

func _on_collector_hitbox_area_entered(area: Area2D) -> void:
	area.get_parent().deActivate()

func _on_spawn_timer_timeout() -> void:
	if spawnIndex >= objectList.size():
		spawnIndex = 0
	objectList[spawnIndex].activate(Vector2(randf_range(0, 650), -100))
	spawnIndex += 1
