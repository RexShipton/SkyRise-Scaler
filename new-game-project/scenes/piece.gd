extends CharacterBody2D


var isPlaced : bool = false
@export var move_speed : int = 200
@export var fall_speed : int = 40
@export var fast_fall_speed : int = 200

signal piece_placed

#@onready var rotation_right: Area2D = $RotationRight
#@onready var rotation_left: Area2D = $RotationLeft
@onready var right_marker: Marker2D = $RightMarker
@onready var left_marker: Marker2D = $LeftMarker

@onready var shape_cast_2d_left: ShapeCast2D = $ShapeCast2DLeft
@onready var shape_cast_2d_right: ShapeCast2D = $ShapeCast2DRight


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	if !isPlaced:
		
		velocity.y = fall_speed + (Input.get_action_strength("block_fast_fall") * fast_fall_speed)
		
		velocity.x = Input.get_axis("block_left","block_right") * move_speed
		
		move_and_slide()
		if velocity.y == 0:
			isPlaced = true
			set_collision_layer_value(4, false)
			set_collision_layer_value(2, true)
			piece_placed.emit()
#	50 60 70     -10 0 10  10  
	if Input.is_action_just_pressed("block_rotate"):
		if !isPlaced:
			if shape_cast_2d_right.is_colliding() and shape_cast_2d_left.is_colliding():
				print("both hit")
				return
			if shape_cast_2d_left.is_colliding():
				var distance = (1 - shape_cast_2d_left.get_closest_collision_safe_fraction()) * (self.global_position.x - left_marker.global_position.x)
				self.global_position.x += distance
			if shape_cast_2d_right.is_colliding():
				print("right hit")
				var distance = (1 - shape_cast_2d_right.get_closest_collision_safe_fraction()) * (self.global_position.x - right_marker.global_position.x)
				self.global_position.x += distance

			#if rotation_left.has_overlapping_bodies():
				#print("left hit")
				#self.global_position.x += (global_position.x - left_marker.global_position.x)
				#print(left_marker.position.x)
			#if rotation_right.has_overlapping_bodies():
				#print("right hit")
				#self.global_position.x += (global_position.x - right_marker.global_position.x)
				#print(right_marker.position.x)
			self.rotation_degrees += 90
			force_update_transform()
			if rotation_degrees > 180:
				rotation_degrees -= 360
