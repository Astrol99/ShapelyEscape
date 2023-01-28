extends KinematicBody2D

const HALT_SPEED = 0.1
const MAX_SPEED = 200.0
const GRAVITY = 2000.0
const JUMP_FORCE = 500.0

export (int) var speed = 100
var velocity = Vector2.ZERO;
var direction = Vector2.ZERO

func _ready():
	$AnimationTree.active = true

func _process(delta):
	direction = Vector2.ZERO
	
	if is_on_floor():
		$AnimationTree.set("parameters/movement/current", int(direction.length() > 50))
	
	if Input.is_action_pressed("move_left1"):
		direction.x = -1
		$Sprite.flip_h = true
	
	if Input.is_action_pressed("move_right1"):
		direction.x = 1
		$Sprite.flip_h = false
	
	if Input.is_action_pressed("jump1") and is_on_floor():
		velocity.y = -JUMP_FORCE
		$AnimationTree.set("parameters/in_air/current", 1)
	
	if Input.is_action_just_released("jump1"):
		$AnimationTree.set("parameters/in_air/current", 0)
	
	if direction == Vector2.ZERO:
		velocity = velocity.linear_interpolate(Vector2.ZERO, delta/HALT_SPEED)
	else:
		velocity = velocity.linear_interpolate(direction * MAX_SPEED, delta/HALT_SPEED)
	
	$AnimationTree.set("parameters/movement_time/scale", 1 + abs(direction.x)/100)
	$AnimationTree.set("parameters/in_air_state/current", int(!$RayCast2D.is_colliding()))
	
	velocity.y += GRAVITY * delta
	move_and_slide(velocity, Vector2.UP)

func _physics_process(delta):
	velocity = move_and_slide(velocity)

