class_name Cat_Goof
extends Actor

onready var sprite = $Sprite
onready var animation_player = $AnimationPlayer

var possessing = false

var area_entered
var screen_size
signal posess
signal unpossess
onready var object : Area2D = null
onready var object2 = get_parent()

func _ready():
	show()
	screen_size = get_viewport_rect().size
	#get_parent().get_node("MultiTargetCam").add_target(self)

func _process(delta):
		# posessing objects
	if Input.is_action_just_pressed("cat_possess"):
		var list : Array = get_overlapping_areas()
		if possessing == false:
			if list.size()>0:
				object = list[0]
				object2 = get_parent()
				if (list[0]).posessed == false:
					print(list[0])
					hide()
					self.connect("posess", object, "on_Player2_posess")
					self.connect("posess", object2, "on_Player2_posess")
					self.connect("unpossess", object, "on_Player2_unpossess")
					self.connect("unpossess", object2, "on_Player2_unpossess")
					emit_signal("posess")
				possessing = true
		elif possessing == true:
			show()
			emit_signal("unpossess")
			self.disconnect("posess", object, "on_Player2_posess")
			self.disconnect("posess", object, "on_Player2_posess")
			self.disconnect("unpossess", object2, "on_Player2_unpossess")
			self.disconnect("unpossess", object2, "on_Player2_unpossess")
			possessing = false

func _physics_process(delta):
	var direction = get_direction()
	if(not possessing):
		
		if direction.x != 0:
			if direction.x > 0:
				sprite.scale.x = abs(sprite.scale.x)
			else:
				sprite.scale.x = -abs(sprite.scale.x)
		
		var is_jump_interrupted = Input.is_action_just_released("jump1") and velocity.y < 0.0
		velocity = calculate_move_velocity(velocity, direction, speed, is_jump_interrupted)
		
		if Input.is_action_pressed("jump1") and is_on_floor():
			velocity.y = -speed.y
		
		var animation = get_new_animation(direction)
		if animation != animation_player.current_animation:
			animation_player.play(animation)
			print(self.name + ": " + animation)
		
		move_and_slide(velocity, Vector2.UP)

func on_Player2_posess():
	possessing = true
	hide()
	self.collision_layer = 0
	self.collision_mask = 0

func on_Player2_unpossess():
	possessing = false
	show()
	self.collision_mask = 1
	self.collision_layer = 1

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
