extends Area2D

var area_entered
var speed : int = 200
var posessed = true
var velocity : Vector2 = Vector2.ZERO
var screen_size
signal posess
var possessing = false
signal unpossess
onready var object : Area2D = null
onready var object2 = get_parent()


func _ready():
	show()
	screen_size = get_viewport_rect().size

func _process(delta):
	
		# posessing objects
	if Input.is_action_just_pressed("cat_possess"):
		var list : Array = get_overlapping_areas()
		if possessing == false:
			if list.size()>0:
				object = list[0]
				object2 = get_parent()
				if (list[0]).posessed == false:
					print(list[0])
					hide()
					self.connect("posess", object, "on_Player2_posess")
					self.connect("posess", object2, "on_Player2_posess")
					self.connect("unpossess", object, "on_Player2_unpossess")
					self.connect("unpossess", object2, "on_Player2_unpossess")
					emit_signal("posess")
				possessing = true
		elif possessing == true:
			show()
			emit_signal("unpossess")
			self.disconnect("posess", object, "on_Player2_posess")
			self.disconnect("posess", object, "on_Player2_posess")
			self.disconnect("unpossess", object2, "on_Player2_unpossess")
			self.disconnect("unpossess", object2, "on_Player2_unpossess")
			possessing = false
			


	


