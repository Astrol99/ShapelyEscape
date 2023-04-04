class_name Actor
extends KinematicBody2D

export var speed = Vector2(300.0, 700.0)
export (int) var push = 100
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
	
	velocity = move_and_slide(velocity, Vector2.UP,false, 4, PI/4, false)
	
	for index in get_slide_count():
		var collision = get_slide_collision(index)
		if collision.collider.is_in_group("bodies"):
			collision.collider.apply_central_impulse(-collision.normal * push)
