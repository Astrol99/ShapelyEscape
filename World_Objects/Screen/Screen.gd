extends Node2D

signal GAME_COMPLETE
signal GAME_OVER

export (NodePath) onready var timer = get_node(timer)
export (NodePath) onready var door = get_node(door)
export (NodePath) onready var spawn_pipe = get_node(spawn_pipe)

export (int) var max_score = 10
export (int) var score = 0

onready var time_label = $Time
onready var score_label = $Score
onready var msg_label = $Message
onready var shape_sprite = $Shape
onready var shapes = [
	preload("res://assets/shapes/circle.png"),
	preload("res://assets/shapes/oval.png"),
	preload("res://assets/shapes/rectangle.png"),
	preload("res://assets/shapes/righttriangle.png"),
	preload("res://assets/shapes/semicircle.png")
]

func _on_Timer_timeout():
	if score < max_score:
		emit_signal("GAME_OVER")
		spawn_pipe.get_child(0).stop()
		time_label.add_color_override("font_color", Color(255,0,0))
		time_label.set_text("0.00")
		msg_label.add_color_override("font_color", Color(255,0,0))
		msg_label.set_text("GAME OVER")
		
		yield(get_tree().create_timer(3.0), "timeout")
		get_tree().reload_current_scene()

func _ready():
	shape_sprite.texture = shapes[randi() % shapes.size()]

func _physics_process(_delta):
	if not timer.is_stopped():
		if score < max_score:
			time_label.set_text(format_second(timer.get_time_left()))
			score_label.set_text("%d/%d" % [score, max_score])
		elif score >= max_score:
			emit_signal("GAME_COMPLETE")
			timer.stop()
			spawn_pipe.get_child(0).stop()
			score_label.set_text("%d/%d" % [score, max_score])
			score_label.add_color_override("font_color", Color(0,255,0))
			msg_label.add_color_override("font_color", Color(0,255,0))
			msg_label.set_text("DOOR IS UNLOCKED")

func format_second(total_seconds: float) -> String:
	var seconds:float = fmod(total_seconds , 60.0)
	var minutes:int   =  int(total_seconds / 60.0) % 60
	if total_seconds <= 60:
		return "%05.2f" % [seconds]
	else:
		return "%02d:%02d" % [minutes, seconds]


func _on_Incinerator_incinerated(body):
	var current_shape_name = shape_sprite.texture.resource_path.replace("res://assets/shapes/", "").replace(".png", "")
	print(current_shape_name)
	print(body.name.to_lower())
	
	if (body.is_in_group("bodies")):
		if (current_shape_name in body.name.to_lower()):
			print("IT WORKED")
			score += 1
			shape_sprite.texture = shapes[randi() % shapes.size()]
		else:
			score -= 1
