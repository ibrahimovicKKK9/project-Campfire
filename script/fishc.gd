extends KinematicBody2D

export var patrol_speed = 100
export var chase_speed = 180
export var wall_distance = 60
export var vision_distance = 200

var velocity = Vector2.ZERO
var direction = -1
var player = null
var state = "patrol"

onready var wall_check = $wallCheck
onready var vision_ray = $visionRay


func _physics_process(delta):

	match state:
		"patrol":
			patrol()
		"chase":
			chase()

	velocity = move_and_slide(velocity)


# ================= PATROL =================
func patrol():

	wall_check.cast_to = Vector2(wall_distance * direction, 0)
	wall_check.force_raycast_update()

	if wall_check.is_colliding():
		direction *= -1
		update_flip()
		return

	velocity.x = direction * patrol_speed
	velocity.y = 0


# ================= CHASE =================
func chase():

	if player == null or !is_instance_valid(player):
		state = "patrol"
		return

	var to_player = player.global_position - global_position
	var distance = to_player.length()

	# 🔥 TAMBAHAN: cuma ngejar kalau player di depan
	if sign(to_player.x) != direction:
		state = "patrol"
		return

	# kalau terlalu jauh balik patroli
	if distance > vision_distance:
		state = "patrol"
		return

	# cek raycast apakah kena player
	vision_ray.cast_to = to_player.normalized() * vision_distance
	vision_ray.force_raycast_update()

	if vision_ray.is_colliding():
		var collider = vision_ray.get_collider()

		if collider.is_in_group("player"):
			var dir = to_player.normalized()
			velocity = dir * chase_speed
			
			direction = sign(dir.x)
			update_flip()
		else:
			velocity = Vector2.ZERO
	else:
		velocity = Vector2.ZERO


# ================= DETECTION =================
func _on_AreaDeteksi_body_entered(body):
	if body.is_in_group("player"):
		player = body
		state = "chase"

func _on_AreaDeteksi_body_exited(body):
	if body == player:
		player = null
		state = "patrol"


# ================= KILL =================
func _on_AreaKill_body_entered(body):
	if body.is_in_group("player"):
		If_die.show()
		get_tree().paused = true


# ================= FLIP =================
func update_flip():
	if direction != 0:
		$AnimatedSprite.flip_h = direction > 0
