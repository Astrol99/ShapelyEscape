extends Area2D
var posessed = false
signal stop
signal PotentialSelect
var inList : Array = get_overlapping_areas()
signal PotentialSelectCat

func on_Player_posess():
	inList = get_overlapping_areas()
	if(inList.size()>0) and (posessed == false):
		connect("PotentialSelect", self.get_parent(), "_on_Area2D_PotentialSelect")
		emit_signal("PotentialSelect")
		posessed = true
func on_Player_unpossess():
	if(posessed == true):
		
		connect("stop", self.get_parent(), "_on_Area2D_stop")
		emit_signal("stop")
		posessed = false

func on_Player2_posess():
	inList = get_overlapping_areas()
	if(inList.size()>0) and (posessed == false):
		connect("PotentialSelectCat", self.get_parent(), "_on_Area2D_PotentialSelectCat")
		emit_signal("PotentialSelectCat")
		posessed = true
func on_Player2_unpossess():
	if(posessed == true):
		
		connect("stop", self.get_parent(), "_on_Area2D_stop")
		emit_signal("stop")
		posessed = false
