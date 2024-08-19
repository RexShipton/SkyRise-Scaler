extends CharacterBody2D

signal die

var jump_buffer : bool = false
var jump_available : bool = true
var push_force = 80.0

@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var jump_buffer_timer: Timer = $JumpBufferTimer
@onready var coyote_timer: Timer = $CoyoteTimer
@onready var death_area_2d: Area2D = $DeathArea2D


@export var SPEED = 300.0
@export var JUMP_VELOCITY = -400.0
@export var Jump_Buffer_Time : float = .1
@export var Coyote_Time: float = .1

var dead : bool = false

func _ready() -> void:
	jump_buffer_timer.wait_time = Jump_Buffer_Time
	coyote_timer.wait_time = Coyote_Time

func _physics_process(delta: float) -> void:
	if dead: return
	
	
	
	Check_OOB()
	
	for i in get_slide_collision_count():
		var c = get_slide_collision(i)
		if c.get_collider() is RigidBody2D:
			c.get_collider().apply_central_impulse(-c.get_normal() * push_force)
	
	# Add the gravity.
	if not is_on_floor():
		if scale.y > -.9 and scale.y < .9:
			scale.y = scale.y * 1.5
		if jump_available and coyote_timer.is_stopped():
			coyote_timer.start()
		animation_player.play("airborne")
		velocity += get_gravity() * delta
		
	if is_on_floor() :
		jump_available = true
		if jump_buffer:
			Jump()
		if Input.get_action_strength("character_crouch") > 0:
			if scale.y < -.9 or scale.y > .9:
				scale.y = scale.y / 1.5
		if Input.get_action_strength("character_crouch") == 0 and scale.y > -.9 and scale.y < .9:
			scale.y = scale.y * 1.5
		if Input.get_axis("character_left", "character_right") == 0:
			animation_player.play("idle")
		if Input.get_axis("character_left", "character_right") != 0:
			animation_player.play("run")
		
		
	# Handle jump.
	if Input.is_action_just_pressed("character_jump"):
		if jump_available:
			Jump()
		else:
			jump_buffer = true
			jump_buffer_timer.start()

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction := Input.get_axis("character_left", "character_right")
	if direction:
		if self.velocity.x < 0:
			self.scale.y = abs(self.scale.y) * -1
			self.rotation_degrees = 180
#		parent.Sprite.flip_h = true
		if self.velocity.x > 0:
			self.scale.y = abs(self.scale.y)
			self.rotation_degrees = 0
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
	move_and_slide()

func Check_OOB() -> void:
	if global_position.x < -10 \
	or global_position.x > 352 \
	or global_position.y > 780:
		dead = true
		die.emit()

func Jump():
	velocity.y = JUMP_VELOCITY
	jump_buffer = false
	jump_available = false

func Die():
	death_area_2d.set_deferred("monitoring", false)
	dead = true
	animation_player.play("die")

func _on_jump_buffer_timer_timeout() -> void:
	jump_buffer = false

func _on_coyote_timer_timeout() -> void:
	jump_available = false

func _on_death_area_2d_body_entered(body: Node2D) -> void:
	Die()
