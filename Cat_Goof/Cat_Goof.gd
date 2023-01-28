extends KinematicBody2D

const HALT_SPEED = 0.1
const MAX_SPEED = 200.0
const GRAVITY = 2000.0
const JUMP_FORCE = 500.0

export (Vector2) var speed = Vector2(300, 500)
var velocity = Vector2.ZERO

onready var sprite = $Sprite
onready var animation_player = $AnimationPlayer

func get_direction():
	return Vector2(
		Input.get_action_strength("move_right1") - Input.get_action_strength("move_left1"),
		-1 if is_on_floor() and Input.is_action_just_pressed("jump1") else 0)

func calculate_move_velocity(linear_velocity, direction, speed, is_jump_interrupted):
	var _velocity = linear_velocity
	_velocity.x = speed.x * direction.x
	if direction.y != 0.0:
		_velocity.y = speed.y * direction.y
	if is_jump_interrupted:
		# Decrease the Y velocity by multiplying it, but don't set it to 0
		# as to not be too abrupt.
		_velocity.y *= 0.6
	return _velocity

func get_new_animation(direction):
	var animation_new = ""
	if is_on_floor():
		if abs(velocity.x) > 0.1:
			animation_new = "run"
		else:
			animation_new = "idle"
	else:
		if velocity.y > 0:
			animation_new = "falling"
		else:
			animation_new = "jumping"
	
	return animation_new

func _physics_process(delta):
	var direction = get_direction()
	
	if direction.x != 0:
		if direction.x > 0:
			sprite.scale.x = 1
		else:
			sprite.scale.x = -1
	
	var is_jump_interrupted = Input.is_action_just_released("jump1") and velocity.y < 0.0
	velocity = calculate_move_velocity(velocity, direction, speed, is_jump_interrupted)
	
	if Input.is_action_pressed("jump1") and is_on_floor():
		velocity.y = -JUMP_FORCE
	
	
	#if direction == Vector2.ZERO:
	#	velocity = velocity.linear_interpolate(Vector2.ZERO, delta/HALT_SPEED)
	#else:
	#	velocity = velocity.linear_interpolate(direction * MAX_SPEED, delta/HALT_SPEED)
	
	var animation = get_new_animation(direction)
	if animation != animation_player.current_animation:
		animation_player.play(animation)
		print(animation)
	
	velocity.y += GRAVITY * delta
	move_and_slide(velocity, Vector2.UP)

