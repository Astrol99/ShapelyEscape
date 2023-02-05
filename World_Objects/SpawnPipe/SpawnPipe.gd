extends Sprite

var shapes = [
	preload("res://World_Objects/Entities/PossessableObjects/PossessableBlock.tscn"),
	preload("res://World_Objects/Entities/PossessableObjects/PossessableCircle.tscn"),
	preload("res://World_Objects/Entities/PossessableObjects/PossessableOval.tscn"),
	preload("res://World_Objects/Entities/PossessableObjects/PossessableRightTriangle.tscn"),
	preload("res://World_Objects/Entities/PossessableObjects/PossessableSemiCircle.tscn")
]




func _on_Timer_timeout():
	var shape = shapes[randi() % shapes.size()].instance()
	shape.set_position(Vector2(0, 288))
	if not "Block" in shape.name: 
		shape.set_scale(Vector2(5,5))
	add_child(shape)
