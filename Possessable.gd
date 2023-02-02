class_name Possessable
extends Actor

export (bool) var dog_possessable = true
export (bool) var cat_possessable = true

var possesseddog = false
var possessedcat = false

var landing = false
onready var sprite = $Sprite


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

func get_direction1():
	return Vector2(
		Input.get_action_strength("move_right1") - Input.get_action_strength("move_left1"),
		-1 if is_on_floor() and Input.is_action_just_pressed("jump1") else 0)

func get_direction2():
	return Vector2(
		Input.get_action_strength("move_right2") - Input.get_action_strength("move_left2"),
		-1 if is_on_floor() and Input.is_action_just_pressed("jump2") else 0)

func _process(delta):
	var direction = Vector2.ZERO
	var is_jump_interrupted = false
	
	if possessedcat and cat_possessable:
		direction = get_direction1()
		is_jump_interrupted = Input.is_action_just_released("jump1") and velocity.y < 0.0
		
		if Input.is_action_pressed("jump1") and is_on_floor():
			velocity.y = -speed.y
		
	elif possesseddog and dog_possessable:
		direction = get_direction2()
		is_jump_interrupted = Input.is_action_just_released("jump2") and velocity.y < 0.0
		
		if Input.is_action_pressed("jump2") and is_on_floor():
			velocity.y = -speed.y
	
	velocity = calculate_move_velocity(velocity, direction, speed, is_jump_interrupted)
	
	if direction.x != 0:
		if direction.x > 0:
			sprite.scale.x = abs(sprite.scale.x)
		else:
			sprite.scale.x = -abs(sprite.scale.x)
			
	if is_on_ceiling():
		velocity.y = 0
	
	move_and_slide(velocity, Vector2.UP)

func _on_Area2D_PotentialSelect():
	possesseddog = true

func _on_Area2D_PotentialSelectCat():
	possessedcat = true

func _on_Area2D_stop():
	possesseddog = false
	possessedcat = false
