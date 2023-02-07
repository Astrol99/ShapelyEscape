extends Node2D

export (float) var delaySpawn = 1

var shapes = [
	preload("res://World_Objects/Entities/PossessableObjects/PossessableRectangle.tscn"),
	preload("res://World_Objects/Entities/PossessableObjects/PossessableCircle.tscn"),
	preload("res://World_Objects/Entities/PossessableObjects/PossessableOval.tscn"),
	preload("res://World_Objects/Entities/PossessableObjects/PossessableRightTriangle.tscn"),
	preload("res://World_Objects/Entities/PossessableObjects/PossessableSemiCircle.tscn")
]

func _ready():
	$Timer.start(delaySpawn)

func _on_Timer_timeout():
	var shape = shapes[randi() % shapes.size()].instance()
	shape.set_position(Vector2((randi() % 200) - 100, 288))
	if not "Rectangle" in shape.name: 
		shape.set_scale(Vector2(5,5))
	add_child(shape)
