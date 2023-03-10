class_name Actor
extends KinematicBody2D

export var speed = Vector2(300.0, 700.0)
onready var gravity = ProjectSettings.get("physics/2d/default_gravity")

const FLOOR_NORMAL = Vector2.UP

var velocity = Vector2.ZERO

func _physics_process(delta):
	if (position.y > 1100):
		position.y = 466
		position.x = 1536
	
	if is_on_ceiling():
		velocity.y = 0
	
	velocity.y += gravity * delta
	velocity.y = min(velocity.y, gravity)
