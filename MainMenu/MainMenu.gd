extends Control

onready var _parallax_background = $ParallaxBackground

func _ready():
	randomize()
	$VBoxContainer/Start.grab_focus()

func _on_Enter_pressed():
	if get_tree().change_scene("res://Level1.tscn") != OK:
		print("An unexpected error occured when trying to switch to the World scene")

func _on_Quit_pressed():
	if OS.has_feature('JavaScript'):
		JavaScript.eval("window.close()")
	get_tree().quit()
