extends Area2D

var player_inside := false
var player_ref


func _on_body_entered(body):
	if body.is_in_group("player") and not GameManager.has_wood:
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
		collect_wood()


func collect_wood():
	GameManager.has_wood = true
	player_ref.hide_interact_icon()
	queue_free() # remove ESSA madeira
