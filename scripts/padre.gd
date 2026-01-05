extends CharacterBody2D

@export var speed: float = 200.0
@onready var interact_icon: Sprite2D = $InteractIcon
@onready var camera: Camera2D = $Camera2D
var tween: Tween

func _ready() -> void:
	interact_icon.visible = false
	interact_icon.modulate.a = 0.0
	interact_icon.scale = Vector2.ONE
	
	if GameManager.spawn_position != Vector2.ZERO:
		global_position = GameManager.spawn_position
		GameManager.spawn_position = Vector2.ZERO
		camera.reset_smoothing()
	
func _physics_process(_delta: float) -> void:
	var direction: Vector2 = get_input_direction()

	velocity = direction * speed
	move_and_slide()


func get_input_direction() -> Vector2:
	var direction := Vector2.ZERO

	direction.x = Input.get_action_strength("move_right") - Input.get_action_strength("move_left")
	direction.y = Input.get_action_strength("move_down") - Input.get_action_strength("move_up")

	return direction.normalized()
	
func show_interact_icon():
	if tween:
		tween.kill()

	interact_icon.visible = true
	interact_icon.modulate.a = 0.0
	interact_icon.scale = Vector2(0.6, 0.6)

	tween = create_tween()
	tween.set_parallel(true)

	# Fade in
	tween.tween_property(
		interact_icon,
		"modulate:a",
		1.0,
		0.2
	).set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_OUT)

	# Scale bounce
	tween.tween_property(
		interact_icon,
		"scale",
		Vector2(1.15, 1.15),
		0.15
	).set_trans(Tween.TRANS_BACK).set_ease(Tween.EASE_OUT)

	tween.chain().tween_property(
		interact_icon,
		"scale",
		Vector2.ONE,
		0.1
	).set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_IN)


func hide_interact_icon():
	if tween:
		tween.kill()

	tween = create_tween()

	# Fade out
	tween.tween_property(
		interact_icon,
		"modulate:a",
		0.0,
		0.15
	).set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_IN)

	tween.finished.connect(func():
		interact_icon.visible = false
	)
