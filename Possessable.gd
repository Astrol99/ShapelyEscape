extends KinematicBody2D
var possesseddog = false
var possessedcat = false
var vel : Vector2 = Vector2.ZERO
var gravity : int = 250
var speed : int = 200
var jumpForce : int = 300

func _process(delta):
	vel.x = 0
	if(self.is_on_floor() == false):
		vel.y += gravity * delta
	if(possesseddog == true):
		#movement inputs here
		if Input.is_action_pressed("move_left2"):
			vel.x -= speed
		if Input.is_action_pressed("move_right2"):
			vel.x += speed
		
		vel.y += gravity * delta
		
		#jump inputs
		if self.is_on_floor() and Input.is_action_just_pressed("jump2"):
				vel.y -= jumpForce
		
		
	if(possessedcat == true):
	
		#movement inputs here
		if Input.is_action_pressed("move_left1"):
			vel.x -= speed
		if Input.is_action_pressed("move_right1"):
			vel.x += speed
		
		vel.y += gravity * delta
		
		#jump inputs
		if self.is_on_floor() and Input.is_action_just_pressed("jump1"):
				vel.y -= jumpForce
	#Applying velocity
	vel = move_and_slide(vel, Vector2.UP)
	
	


func _on_Area2D_PotentialSelect():
	possesseddog = true

func _on_Area2D_PotentialSelectCat():
	possessedcat = true



func _on_Area2D_stop():
	possesseddog = false
	possessedcat = false
