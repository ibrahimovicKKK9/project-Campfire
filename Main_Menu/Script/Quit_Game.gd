extends Button


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

onready var Button_Box = $"../../Box2"
onready var AudioMP3 = $"../AudioStreamPlayer2D"

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_Quit_Game_pressed():
	get_tree().quit()


func _on_Quit_Game_mouse_entered():
	Button_Box.visible = true



func _on_Quit_Game_mouse_exited():
	Button_Box.visible = false
