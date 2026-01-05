extends Area2D

var player_inside := false
var player_ref

@onready var wood_pile: Node2D = $WoodPile
@onready var woods := wood_pile.get_children()


func _ready():
	update_wood_pile()


func _on_body_entered(body):
	if body.is_in_group("player") and GameManager.has_wood:
		player_inside = true
		player_ref = body
		body.show_interact_icon()


func _on_body_exited(body):
	if body.is_in_group("player"):
		player_inside = false
		player_ref = null
		body.hide_interact_icon()


func _process(_delta):
	if player_inside and Input.is_action_just_pressed("interact"):
		deliver_wood()


func deliver_wood():
	if GameManager.wood_delivered >= GameManager.max_wood:
		return

	GameManager.has_wood = false
	GameManager.wood_delivered += 1

	show_next_wood()

	player_ref.hide_interact_icon()
	print("Madeira entregue:", GameManager.wood_delivered)


func update_wood_pile():
	for i in woods.size():
		woods[i].visible = i < GameManager.wood_delivered
		woods[i].scale = Vector2.ONE


func show_next_wood():
	var index := GameManager.wood_delivered - 1
	if index >= woods.size():
		return

	var wood := woods[index]
	wood.visible = true
	wood.scale = Vector2.ZERO

	var tween := wood.create_tween()
	tween.tween_property(
		wood,
		"scale",
		Vector2.ONE,
		0.2
	).set_trans(Tween.TRANS_BACK).set_ease(Tween.EASE_OUT)
