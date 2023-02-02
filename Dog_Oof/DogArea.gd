extends Area2D
var area_entered
var speed : int = 200
var velocity : Vector2 = Vector2.ZERO
var screen_size
signal posess
var posessed = true
var possessing = false
signal unpossess
onready var object : Area2D = null
onready var object2 = get_parent()


func _ready():
	show()
	screen_size = get_viewport_rect().size

func _process(delta):
	
	#movement of ghost
	if Input.is_action_just_pressed("possess"):
		var list : Array = get_overlapping_areas()
		if possessing == false:
			
			if list.size()>0:
				if list[0].posessed == false:
					object = list[0]
					object2 = get_parent()
					hide()
					self.connect("posess", object, "on_Player_posess")
					self.connect("posess", object2, "on_Player_posess")
					self.connect("unpossess", object, "on_Player_unpossess")
					self.connect("unpossess", object2, "on_Player_unpossess")
					emit_signal("posess")
				possessing = true
		elif possessing == true:
			show()
			emit_signal("unpossess")
			self.disconnect("posess", object, "on_Player_posess")
			self.disconnect("posess", object2, "on_Player_posess")
			self.disconnect("unpossess", object2, "on_Player_unpossess")
			self.disconnect("unpossess", object, "on_Player_unpossess")
			possessing = false
			
	

