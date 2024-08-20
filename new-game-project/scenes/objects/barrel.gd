extends RigidBody2D

#@onready var explosion: Node2D = $Explosion
@onready var explosion = preload("res://scenes/objects/explosion.tscn")
@onready var crush_node: Node2D = $CrushNode

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	crush_node.is_crushed.connect(_on_is_crushed)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func die():
	var new_explosion = explosion.instantiate()
	get_parent().add_child(new_explosion)
	new_explosion.global_position = self.global_position
	queue_free()

func ApplyForce(force_added):

	apply_central_force(force_added * 1000)


func _on_death_area_2d_body_entered(body: Node2D) -> void:
	die()


func _on_is_crushed():
	die()
	
