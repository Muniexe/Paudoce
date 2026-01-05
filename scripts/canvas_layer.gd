extends CanvasLayer

@onready var rect: ColorRect = $ColorRect
var tween: Tween


func _ready():
	rect.modulate.a = 0.0


func fade_out(time := 0.25) -> void:
	if tween:
		tween.kill()

	rect.visible = true
	tween = create_tween()
	tween.tween_property(rect, "modulate:a", 1.0, time)


func fade_in(time := 0.25) -> void:
	if tween:
		tween.kill()

	rect.visible = true
	tween = create_tween()
	tween.tween_property(rect, "modulate:a", 0.0, time)

	tween.finished.connect(func():
		rect.visible = false
	)
