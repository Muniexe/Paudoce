extends Area2D

var player_inside := false
var player_ref
@onready var wood_pile: Node2D = $WoodPile

func _on_body_entered(body):
	if body.is_in_group("player") and GameManager.quest_state == GameManager.QuestState.DELIVER_WOOD:
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
	GameManager.has_wood = false
	GameManager.quest_state = GameManager.QuestState.COMPLETED
	wood_pile.visible = true
	player_ref.hide_interact_icon()
	print("Objetivo concluído!")
