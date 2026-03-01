extends CanvasLayer


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	hide()


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_repeat_pressed():
	get_tree().reload_current_scene()
	get_tree().paused = false
	Win.hide()



func _on_menu_pressed():
	get_tree().change_scene("res://Main_Menu/Scene/Main_Menu.tscn")
	Win.hide()
