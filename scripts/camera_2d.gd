extends Camera2D

@export var smooth_speed := 6.0

func _ready():
	position_smoothing_enabled = true
	position_smoothing_speed = smooth_speed
