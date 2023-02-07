extends Area2D

onready var screen = get_node("../Screen")
var currentbody = null #placeholder for current needed shape

signal kill
signal shape_burned
func _on_Incinerator_body_shape_entered(body):
	if(body.burnable == true):
		connect("kill", body, "on_Incinerator_kill")
		emit_signal("kill")
		disconnect("kill", body, "on_Incinerator_kill")
		if(body.sprite == screen.shape_sprite): #condition could be changed, I dont think this works
			connect("shape_burned", screen, "on_shape_incinerated")
			emit_signal("shape_burned")
			disconnect("shape_burned", screen, "on_shape_incinerated")
