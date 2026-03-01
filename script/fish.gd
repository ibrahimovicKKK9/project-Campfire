extends KinematicBody2D

var speed = 150
var velocity = Vector2()
var target_player = null

onready var area_deteksi = $AreaDeteksi
onready var area_kill = $AreaKill
onready var sprite = $Sprite

func _ready():
	print("Fish Ready!")
	area_deteksi.connect("area_entered", self, "_on_area_deteksi_entered")
	area_kill.connect("area_entered", self, "_on_area_kill_entered")

func _physics_process(_delta):
	if target_player:
		chase_player()
	else:
		velocity = Vector2.ZERO
	
	move_and_slide(velocity)

func chase_player():
	var direction = position.direction_to(target_player.position)
	velocity = direction * speed
	
	if direction.x < 0:
		sprite.flip_h = true
	else:
		sprite.flip_h = false

# Cek semua yang masuk area (bukan hanya player)
func _on_area_deteksi_entered(area):
	print("Ada yang masuk AreaDeteksi: ", area.name)
	print("Groupnya: ", area.get_groups())
	
	if area.is_in_group("player"):
		target_player = area.get_parent()

func _on_area_kill_entered(area):
	if area.is_in_group("player"):
		area.get_parent().queue_free()
