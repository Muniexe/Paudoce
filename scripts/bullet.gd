extends Area2D

@export var speed := 700
@export var lifetime := 1.2

func _ready():
	await get_tree().create_timer(lifetime).timeout
	queue_free()

func _process(delta):
	position += Vector2.RIGHT.rotated(rotation) * speed * delta

func _on_body_entered(_body):
	queue_free()
