extends KinematicBody2D

# Variabel pengaturan (Bisa diubah di Inspector)
export var speed = 200        # Kecepatan berenang
export var speed_sprint = 350 # Kecepatan saat Cepat Renang
export var friction = 0.1     # Efek licin air (0.1 berarti licin, 1.0 berarti kaku)

export var Stamina_Player = 100 # Nilai Stamina Player
export var Stamina_time_ngurang = 15 # Nilai Waktu Stamina Ngurang Player
export var Stamina_time_regen = 12 # Nilai Waktu Stamina regen Player

onready var AnimatedPlayer = $AnimatedSprite
onready var Label_Stamina = $"Label Stamina"
onready var Label_Speed = $"Label Speed"

var velocity = Vector2.ZERO

func _process(delta):
	Label_Speed.text = "Speed: " + str(speed)
	Label_Stamina.text = "Stamina: " + str(Stamina_Player)

func _physics_process(delta):
	# 1. Ambil input dari keyboard (Panah atau WASD)
	var input_vector = Vector2.ZERO
	input_vector.x = Input.get_action_strength("kanan") - Input.get_action_strength("kiri")
	input_vector.y = Input.get_action_strength("bawah") - Input.get_action_strength("atas")
	
	# 2. Normalisasi (Agar jalan miring tidak lebih cepat dari jalan lurus)
	input_vector = input_vector.normalized()
	
	# 3. Tentukan kecepatan target
	if input_vector != Vector2.ZERO:
		# Jika mencet tombol, akselerasi ke arah tersebut
		velocity = velocity.linear_interpolate(input_vector * speed, 0.1)
		
		
		if input_vector.x > 0:
			AnimatedPlayer.flip_h = false 
		elif input_vector.x < 0:
			AnimatedPlayer.flip_h = true  
	else:
		# Jika dilepas, perlambat sampai berhenti (Efek gesekan air)
		velocity = velocity.linear_interpolate(Vector2.ZERO, friction)
		
	if Input.is_action_pressed("sprint") and Stamina_Player > 0:
		speed = speed_sprint
		Stamina_Player -= Stamina_time_ngurang * delta
	else:
		speed = 200
		Stamina_Player += Stamina_time_regen * delta
		
	Stamina_Player = clamp(Stamina_Player, 0, 100)
	# 4. Gerakkan Player
	velocity = move_and_slide(velocity)
