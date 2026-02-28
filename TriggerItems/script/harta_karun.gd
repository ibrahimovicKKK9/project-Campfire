extends Area2D

var taken = false
# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func _on_harta_karun_body_entered(body):
		taken = true
		monitoring = false
		$CollisionShape2D.disabled = true
		$AudioStreamPlayer2D.play()
		hide()
		
		
		yield(get_tree().create_timer(0.6),"timeout")
		queue_free()
