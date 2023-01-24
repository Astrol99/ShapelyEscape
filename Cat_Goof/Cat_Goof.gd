extends KinematicBody2D

var velocity = Vector2.ZERO
const FLOOR_NORMAL = Vector2.UP

export var speed = Vector2(400.0, 500.0)
export var gravity = 3500.0

func get_direction() -> Vector2:
	return Vector2(
		Input.get_action_strength("move_right1") - Input.get_action_strength("move_left1"),
		-Input.get_action_strength("jump1") if is_on_floor() and Input.is_action_just_pressed("jump1") else 0.0)

func calculate_move_velocity(linear_velocity: Vector2, direction: Vector2, speed: Vector2, is_jump_interrupted: bool) -> Vector2:
	var velocity = linear_velocity
	velocity.x = speed.x * direction.x
	if direction.y != 0.0:
		velocity.y = speed.y * direction.y
	if is_jump_interrupted:
		velocity.y = 0.0
	return velocity

func _physics_process(delta: float) -> void:
	var is_jump_interrupted = Input.is_action_just_released("jump1") and velocity.y < 0.0
	var direction = get_direction()
	velocity = calculate_move_velocity(velocity, direction, speed, is_jump_interrupted)
	var snap = Vector2.DOWN * 60.0 if direction.y == 0.0 else Vector2.ZERO
	velocity.y += gravity * delta
	velocity = move_and_slide_with_snap(velocity, snap, FLOOR_NORMAL, true)
