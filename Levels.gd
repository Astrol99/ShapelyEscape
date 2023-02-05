extends Node2D

export (int) var max_score = 10
export (int) var score = 0
export (float) var time = 60

func _on_Timer_timeout():
	if score < max_score:
		print("GAME OVER")
