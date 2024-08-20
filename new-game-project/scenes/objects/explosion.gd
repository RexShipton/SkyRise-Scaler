extends Node2D


@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D
@onready var explosion_sound: AudioStreamPlayer = $ExplosionSound

@onready var area_2d: Area2D = $Area2D
@onready var center_marker_2d: Marker2D = $CenterMarker2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	play_explosion()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func play_explosion():
	explosion_sound.play()
	animated_sprite_2d.play("explode")
	await animated_sprite_2d.animation_finished
	visible = false
	await explosion_sound.finished
	queue_free()


func _on_area_2d_body_entered(body: Node2D) -> void:
	#var direction = (center_marker_2d.global_position - body.global_position).normalized()
	#var fraction_of_force = 1- (area_2d.get_child(0).shape.radius / body.global_position.distance_to(center_marker_2d.global_position))
	#var actual_force = fraction_of_force * direction * 20
	var direction = (body.global_position - center_marker_2d.global_position).normalized()
	var actual_force = 5000*direction/(body.global_position-center_marker_2d.global_position).length()
	body.ApplyForce(actual_force)
