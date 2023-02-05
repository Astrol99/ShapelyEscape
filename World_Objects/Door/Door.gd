extends Area2D

export (String) var NextLevel

var locked = true

func _on_Door_body_entered(body):
	if not locked and ("Cat" or "Dog" in body.name):
		get_tree().change_scene(NextLevel)
