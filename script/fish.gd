extends KinematicBody2D



#speed
export var speed = 100

#direction
#arah
var direction  = -1


var velocity = Vector2.ZERO


#connect from area2d
func _ready():
	$Area2D.connect("body_entered", self, "_on_Area2D_body_entered")
	print("Area monitoring:", $Area2D.monitoring)
	
# if player on area2d

func _on_Area2D_body_entered(body):
	if body.name == "Player":
		get_tree().reload_current_scene()

	

		
func _physics_process(delta):
	velocity.x = direction * speed
	velocity = move_and_slide(velocity)
	
	if $RayCast2D.is_colliding():
		direction *= -1
		$RayCast2D.cast_to.x *= -1
		
  









