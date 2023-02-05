extends Node2D

export (NodePath) onready var level = get_node(level)
export (NodePath) onready var timer = get_node(timer)
onready var time_label = $Time
onready var score_label = $Score

func _ready():
	timer.start(level.time)

func _physics_process(_delta):
	time_label.set_text(format_second(timer.get_time_left()))
	score_label.set_text("%d/%d" % [level.score, level.max_score])

func format_second(total_seconds: float) -> String:
	var seconds:float = fmod(total_seconds , 60.0)
	var minutes:int   =  int(total_seconds / 60.0) % 60
	if total_seconds <= 60:
		return "%05.2f" % [seconds]
	else:
		return "%02d:%02d" % [minutes, seconds]
