extends CanvasLayer



func _ready():
	hide()
	
	




func _on_repeat_pressed():
	get_tree().reload_current_scene()
	get_tree().paused = false
	If_die.hide()



func _on_menu_pressed():
	get_tree().change_scene("res://Main_Menu/Scene/Main_Menu.tscn")
	If_die.hide()
