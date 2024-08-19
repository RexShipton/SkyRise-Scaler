extends Sprite2D

@export var textures : Array

var rotAmount : float = 0
var active : bool = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	texture = load(textures[randi_range(0,textures.size()-1)])
	rotAmount = randf_range(-250,250)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta : float) -> void:
	if !active: return
	
	rotation_degrees += delta * rotAmount
	global_position.y += ProjectSettings.get_setting("physics/2d/default_gravity") * delta * .15

func activate(pos : Vector2) -> void:
	active = true
	global_position = pos

func deActivate() -> void:
	active = false
	global_position = Vector2(-1000, -1000)
