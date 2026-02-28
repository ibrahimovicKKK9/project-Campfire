extends KinematicBody2D


#player
var player = null

#speed
export var speed = 100

#direction
#arah
var direction  = -1


#connect from area2d
func _ready():
	$Area2D.connect("body_entered",self,"_on_body_entered")
	$Area2D.connect("body_exited",self,"_on_body_exited")
	
# if player on area2d
func _on_body_entered(body):
	if	body.name == "player":
		player = body

# if player exit
func _on_body_exited(body):
	if body.name == "player":
		player = null
		
func _physics_process(delta):
	


