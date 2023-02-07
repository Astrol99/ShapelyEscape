extends Area2D

export (NodePath) onready var screen = get_node(screen)

signal incinerated(body)

func _on_Incinerator_body_entered(body):
	print(body.name)
	if ("Possessable" in body.name):
		body.queue_free()
	emit_signal("incinerated", body)
