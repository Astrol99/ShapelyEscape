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

func _process(delta):
	$Label.text = "%.02f" % $Timer.get_time_left()

func _on_Timer_timeout():
	$Label.text = "%.02f" % $Timer.get_time_left()
	var shape = shapes[randi() % shapes.size()].instance()
	shape.set_position(Vector2((randi() % 200) - 100, 200))
	shape.set_z_index(-1)
	add_child(shape)
