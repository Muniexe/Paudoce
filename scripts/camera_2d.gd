extends Camera2D

@export var smooth_speed := 6.0

@export var shake_strength := 6.0
@export var shake_duration := 0.12

var shake_time := 0.0
var original_offset := Vector2.ZERO

func _ready():
	position_smoothing_enabled = true
	position_smoothing_speed = smooth_speed
	original_offset = offset

func _process(delta):
	if shake_time > 0:
		shake_time -= delta
		offset = original_offset + Vector2(
			randf_range(-shake_strength, shake_strength),
			randf_range(-shake_strength, shake_strength)
		)
	else:
		offset = original_offset

func shake():
	shake_time = shake_duration
