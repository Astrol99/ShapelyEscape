extends Area2D

export (String) var NextLevel

var locked = true

func _ready():
	$AnimatedSprite.play("close")

func _on_Door_body_entered(body):
	if not locked and ("Cat" or "Dog" in body.name):
		get_tree().change_scene(NextLevel)


func _on_Screen_GAME_COMPLETE():
	locked = false
	$AnimatedSprite.play("open")
