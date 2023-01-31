extends KinematicBody2D
var possesseddog = false
var possessedcat = false
export (Vector2) var speed = Vector2(300, 600)
const GRAVITY = 1200.0
var velocity = Vector2.ZERO
var landing = false
onready var sprite = $Sprite

func get_direction1():
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

func get_direction2():
	return Vector2(
		Input.get_action_strength("move_right2") - Input.get_action_strength("move_left2"),
		-1 if is_on_floor() and Input.is_action_just_pressed("jump2") else 0)




func _process(delta):
		if(possesseddog == true):
			var direction = get_direction2()
			if direction.x != 0:
				if direction.x > 0:
					sprite.scale.x = 1
				else:
					sprite.scale.x = -1
			
			var is_jump_interrupted = Input.is_action_just_released("jump2") and velocity.y < 0.0
			velocity = calculate_move_velocity(velocity, direction, speed, is_jump_interrupted)
			
			if Input.is_action_pressed("jump2") and is_on_floor():
				velocity.y = -speed.y
			
			if is_on_ceiling():
				velocity.y = 0
			
			
			velocity.y += GRAVITY * delta
			velocity.y = min(velocity.y, GRAVITY)
			move_and_slide(velocity, Vector2.UP)
			
		if(possessedcat == true):
			
			var direction = get_direction1()
			if direction.x != 0:
				if direction.x > 0:
					sprite.scale.x = 1
				else:
					sprite.scale.x = -1
			
			var is_jump_interrupted = Input.is_action_just_released("jump1") and velocity.y < 0.0
			velocity = calculate_move_velocity(velocity, direction, speed, is_jump_interrupted)
			
			if Input.is_action_pressed("jump1") and is_on_floor():
				velocity.y = -speed.y
			
			if is_on_ceiling():
				velocity.y = 0
			
			velocity.y += GRAVITY * delta
			velocity.y = min(velocity.y, GRAVITY)
			move_and_slide(velocity, Vector2.UP)
	
	


func _on_Area2D_PotentialSelect():
	possesseddog = true

func _on_Area2D_PotentialSelectCat():
	possessedcat = true



func _on_Area2D_stop():
	possesseddog = false
	possessedcat = false
