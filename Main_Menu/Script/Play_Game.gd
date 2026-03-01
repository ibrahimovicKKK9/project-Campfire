extends Node


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

onready var Button_Box = $"../../Box1"
onready var AudioMP3 = $"../AudioStreamPlayer2D"
onready var AnimationFade = $"../../AnimationPlayer"

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_Play_Game_pressed():
	get_tree().paused = false
	
	print("Game dimulai")
	AudioMP3.play() # Suara Boom mulai
	
	# Jalankan animasi fade out
	AnimationFade.play_backwards("fade_panel")
	AnimationFade.play_backwards("fade")
	
	# JURUS RAHASIA: Tunggu animasinya selesai (bukan audionya)
	# Pastikan "fade" adalah nama animasi terakhir yang menutupi layar
	yield(AnimationFade, "animation_finished")
	
	# Pindah scene tepat saat layar sudah gelap
	get_tree().change_scene("res://world/world.tscn")



func _on_Play_Game_mouse_entered():
	Button_Box.visible = true


func _on_Play_Game_mouse_exited():
	Button_Box.visible = false
