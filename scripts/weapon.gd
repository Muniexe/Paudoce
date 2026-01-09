extends Node2D

@export var bullet_scene: PackedScene
@export var pellets := 6
@export var spread_degrees := 25.0
@export var fire_rate := 0.6

@export var recoil_distance := 8.0
@export var recoil_time := 0.08

@onready var muzzle: Marker2D = $Marker2D
@onready var sprite: Sprite2D = $Sprite2D
@onready var shot_sound: AudioStreamPlayer2D = $ShotSound



var can_shoot := true
var original_position: Vector2

func _ready():
	original_position = position

func _process(_delta):
	look_at(get_global_mouse_position())
	_handle_flip()

	if Input.is_action_just_pressed("shoot") and can_shoot:
		shoot()

func shoot():
	var cam: Camera2D =$"../Camera2D"
	if cam:
		cam.shake()

	can_shoot = false
	shot_sound.play()
	
	
	for i in pellets:
		var bullet = bullet_scene.instantiate()
		bullet.global_position = muzzle.global_position

		var spread = deg_to_rad(
			randf_range(-spread_degrees / 2, spread_degrees / 2)
		)

		bullet.rotation = rotation + spread
		get_tree().current_scene.add_child(bullet)

	_recoil()

	await get_tree().create_timer(fire_rate).timeout
	can_shoot = true
	
# ===============================
# 🔁 RECUO DA ARMA
# ===============================
func _recoil():
	var dir = Vector2.RIGHT.rotated(rotation)
	var recoil_pos = original_position - dir * recoil_distance

	var tween := create_tween()
	tween.tween_property(
		self,
		"position",
		recoil_pos,
		recoil_time
	).set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_OUT)

	tween.tween_property(
		self,
		"position",
		original_position,
		recoil_time * 2
	).set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_OUT)


# ===============================
# 🔄 FLIP DA ARMA
# ===============================
func _handle_flip():
	if global_position.x > get_global_mouse_position().x:
		sprite.flip_v = true
	else:
		sprite.flip_v = false
		
