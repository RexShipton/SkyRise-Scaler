extends CharacterBody2D


var isPlaced : bool = false
@export var move_speed : int = 200
@export var fall_speed : int = 40
@export var fast_fall_speed : int = 200

signal piece_placed

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if !isPlaced:
		velocity.y = fall_speed + (Input.get_action_strength("block_fast_fall") * fast_fall_speed)
		
		velocity.x = Input.get_axis("block_left","block_right") * move_speed
		
		move_and_slide()
		if velocity.y == 0:
			isPlaced = true
			piece_placed.emit()
	
	if Input.is_action_just_pressed("block_rotate"):
		if !isPlaced:
			self.rotation_degrees += 90
			if rotation_degrees > 180:
				rotation_degrees -= 360
