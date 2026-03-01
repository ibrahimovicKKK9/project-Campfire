extends CanvasLayer



func _ready():
	hide()
	
	




func _on_repeat_pressed():
	get_tree().reload_current_scene()
	get_tree().paused = false
	If_die.hide()
