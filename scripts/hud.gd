extends CanvasLayer

@onready var wood_label: Label = $Labelwood
@onready var tutorial_label: Label = $TutorialLabel

var tutorial_tween: Tween


func _ready():
	# Registra o HUD no GameManager
	GameManager.hud = self

	# Estado inicial
	tutorial_label.visible = false
	tutorial_label.modulate.a = 0.0

	update_wood_label()
	# 👇 TEXTO INICIAL
	await get_tree().create_timer(0.5).timeout
	show_tutorial("Pegue as madeiras e leve até a igreja")


func _process(_delta):
	update_wood_label()


# ===============================
# CONTADOR DE MADEIRAS
# ===============================
func update_wood_label():
	wood_label.text = "Madeiras: %d / %d" % [
		GameManager.wood_delivered,
		GameManager.max_wood
	]

	if GameManager.wood_delivered >= GameManager.max_wood:
		wood_label.visible = false
	else:
		wood_label.visible = true


# ===============================
# TEXTO DE OBJETIVO (TUTORIAL)
# ===============================
func show_tutorial(text: String):
	if tutorial_tween:
		tutorial_tween.kill()

	tutorial_label.text = text
	tutorial_label.visible = true
	tutorial_label.modulate.a = 0.0

	tutorial_tween = create_tween()

	# Fade in
	tutorial_tween.tween_property(
		tutorial_label,
		"modulate:a",
		1.0,
		0.2
	)

	# Espera um pouco na tela
	tutorial_tween.tween_interval(1.8)

	# Fade out
	tutorial_tween.tween_property(
		tutorial_label,
		"modulate:a",
		0.0,
		0.3
	)

	tutorial_tween.finished.connect(func():
		tutorial_label.visible = false
	)
