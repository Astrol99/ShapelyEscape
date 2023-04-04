class_name Dog_Oof
extends Actor

var burnable = false
onready var sprite = $Sprite
onready var animation_player = $AnimationPlayer

var possessing = false

func get_direction():
	return Vector2(
		Input.get_action_strength("move_right2") - Input.get_action_strength("move_left2"),
		-1 if is_on_floor() and Input.is_action_just_pressed("jump2") else 0)

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

var landing = false
func get_new_animation(direction):
	var animation_new = ""
	if is_on_floor():
		if landing:
			animation_new = "landing"
			landing = false
		elif abs(velocity.x) > 0.1:
			animation_new = "run"
		else:
			animation_new = "idle"
	else:
		if velocity.y > 0:
			landing = true
			animation_new = "falling"
		else:
			animation_new = "jumping"
	
	return animation_new

func on_Player_posess():
	possessing = true
	self.collision_layer = 0
	self.collision_mask = 0
	hide()

func on_Player_unpossess_two(body):
	possessing = false
	self.collision_layer = 1
	self. collision_mask = 1
	show()

func on_Player_unpossess():
	possessing = false
	self.collision_layer = 1
	self. collision_mask = 1
	show()

func _physics_process(delta):
	var direction = get_direction()
	if(not possessing):
		if direction.x != 0:
			if direction.x > 0:
				sprite.scale.x = abs(sprite.scale.x)
			else:
				sprite.scale.x = -abs(sprite.scale.x)
		
		var is_jump_interrupted = Input.is_action_just_released("jump2") and velocity.y < 0.0
		velocity = calculate_move_velocity(velocity, direction, speed, is_jump_interrupted)
		
		if Input.is_action_pressed("jump2") and is_on_floor():
			velocity.y = -speed.y
		
		var animation = get_new_animation(direction)
		if animation != animation_player.current_animation:
			animation_player.play(animation)
			print(self.name + ": " + animation)
