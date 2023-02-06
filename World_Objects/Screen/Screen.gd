extends Node2D

export (NodePath) onready var timer = get_node(timer)

export (int) var max_score = 10
export (int) var score = 0
export (float) var time = 60

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
		msg_label.set_text("GAME OVER")

func _on_shape_incinerated(shape):
	if (shape in shape_sprite.texture.resource_path):
		score += 1
		shape_sprite.texture = shapes[randi() % shapes.size()]

func _ready():
	timer.start(time)

func _physics_process(_delta):
	if score < max_score:
		time_label.set_text(format_second(timer.get_time_left()))
		score_label.set_text("%d/%d" % [score, max_score])

func format_second(total_seconds: float) -> String:
	var seconds:float = fmod(total_seconds , 60.0)
	var minutes:int   =  int(total_seconds / 60.0) % 60
	if total_seconds <= 60:
		return "%05.2f" % [seconds]
	else:
		return "%02d:%02d" % [minutes, seconds]
