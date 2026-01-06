extends CanvasLayer

@onready var wood_label: Label = $Labelwood
@onready var tutorial_panel: Panel = $TutorialPanel
@onready var tutorial_label: Label = $TutorialPanel/TutorialLabel

var tutorial_tween: Tween

func _ready():
	GameManager.hud = self

	tutorial_panel.visible = false
	tutorial_panel.modulate.a = 0.0

	update_wood_label()

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

	wood_label.visible = GameManager.wood_delivered < GameManager.max_wood


# ===============================
# TUTORIAL BOX
# ===============================
func show_tutorial(text: String):
	if tutorial_tween:
		tutorial_tween.kill()

	tutorial_label.text = text
	tutorial_panel.visible = true
	tutorial_panel.modulate.a = 0.0

	tutorial_tween = create_tween()

	# Fade in
	tutorial_tween.tween_property(
		tutorial_panel,
		"modulate:a",
		1.0,
		0.25
	)

	# Tempo na tela
	tutorial_tween.tween_interval(2.0)

	# Fade out
	tutorial_tween.tween_property(
		tutorial_panel,
		"modulate:a",
		0.0,
		0.35
	)

	tutorial_tween.finished.connect(func():
		tutorial_panel.visible = false
	)
