extends CanvasLayer

@onready var counter_label: Label = $Label
@onready var tutorial_label: Label = $TutorialLabel


func _ready():
	update_counter()
	show_tutorial("Pegue a madeira e leve até a igreja")


func _process(_delta):
	update_counter()


func update_counter():
	counter_label.text = "Madeiras: %d / %d" % [
		GameManager.wood_delivered,
		GameManager.max_wood
	]


func show_tutorial(text: String):
	tutorial_label.text = text
	tutorial_label.visible = true
	tutorial_label.modulate.a = 0.0

	var tween := create_tween()

	# Fade in
	tween.tween_property(
		tutorial_label,
		"modulate:a",
		1.0,
		0.4
	)

	# Espera na tela
	tween.tween_interval(3.0)

	# Fade out
	tween.tween_property(
		tutorial_label,
		"modulate:a",
		0.0,
		0.4
	)

	tween.finished.connect(func():
		tutorial_label.visible = false
	)
