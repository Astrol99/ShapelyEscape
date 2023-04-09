extends Control

func _ready():
	randomize()
	$VBoxContainer/Start.grab_focus()

func _process(delta):
	$ParallaxBackground/ParallaxLayer.motion_offset.x += -50 * delta

func _on_Enter_pressed():
	if get_tree().change_scene("res://Level1/Level1.tscn") != OK:
		print("An unexpected error occured when trying to switch to the World scene")

func _on_Quit_pressed():
	if OS.has_feature('JavaScript'):
		JavaScript.eval("window.close()")
	get_tree().quit()
