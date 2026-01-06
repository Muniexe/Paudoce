extends Area2D

@export var target_scene: String = "res://fases/interior_da_igreja.tscn"

var player_inside := false
var player_ref: CharacterBody2D


func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		player_inside = true
		player_ref = body
		body.show_interact_icon() # 👈 SEMPRE mostra


func _on_body_exited(body: Node2D) -> void:
	if body.is_in_group("player"):
		player_inside = false
		player_ref = null
		body.hide_interact_icon()


func _process(_delta: float) -> void:
	if player_inside and Input.is_action_just_pressed("interact"):
		if can_enter():
			enter_house()
		else:
			show_blocked_message()


func can_enter() -> bool:
	return GameManager.wood_delivered >= GameManager.max_wood


func show_blocked_message():
	if GameManager.hud:
		GameManager.hud.show_tutorial(
			"Leve todas as madeiras para a igreja"
		)


func enter_house() -> void:
	$DoorSound.play()

	if player_ref:
		player_ref.hide_interact_icon()

	Fade.fade_out()
	await get_tree().create_timer(0.25).timeout
	get_tree().change_scene_to_file(target_scene)
	Fade.fade_in()
