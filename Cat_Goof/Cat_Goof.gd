extends KinematicBody2D

<<<<<<< HEAD
const HALT_SPEED = 0.1
const MAX_SPEED = 400.0
=======
export (int) var speed = 200
var velocity = Vector2.ZERO;
>>>>>>> cc9e5366ace9f05a828a033f5a38a5dfb2d4fa96

const GRAVITY = 1500.0
const JUMP_FORCE = 1000.0

var direction = Vector2.ZERO
var velocity = Vector2.ZERO
var jump_force = Vector2.ZERO

<<<<<<< HEAD
func _process(delta):
	direction = Vector2.ZERO
	
	if Input.is_action_pressed("move_left1"):
		direction.x = -1
		$Sprite.flip_h = true
	
	if Input.is_action_pressed("move_right1"):
		direction.x = 1
		$Sprite.flip_h = false
	
	if direction == Vector2.ZERO:
		velocity = velocity.linear_interpolate(Vector2.ZERO, delta/HALT_SPEED)
	else:
		velocity = velocity.linear_interpolate(direction * MAX_SPEED, delta/HALT_SPEED)
	
	if Input.is_action_just_pressed("jump1") and is_on_floor():
		velocity.y = -JUMP_FORCE
	
	velocity.y += GRAVITY * delta
	move_and_slide(velocity, Vector2.UP)
=======
func _physics_process(delta):
	get_input()
	velocity.y = max(velocity.y, speed.y)
	velocity = move_and_slide(velocity)
>>>>>>> cc9e5366ace9f05a828a033f5a38a5dfb2d4fa96
