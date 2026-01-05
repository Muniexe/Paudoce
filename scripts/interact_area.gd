extends Area2D

@export var target_scene: String = "res://fases/test/house_interior.tscn"

var player_inside := false
var player_ref: CharacterBody2D


func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		player_inside = true
		player_ref = body
		print("Player entrou na área")
		body.show_interact_icon()


func _on_body_exited(body: Node2D) -> void:
	if body.is_in_group("player"):
		player_inside = false
		player_ref = null
		print("Player saiu da área")
		body.hide_interact_icon()


func _process(_delta: float) -> void:
	if player_inside and Input.is_action_just_pressed("interact"):
		enter_house()


func enter_house() -> void:
	$DoorSound.play()
	if player_ref:
		player_ref.hide_interact_icon()

	Fade.fade_out()
	await get_tree().create_timer(0.25).timeout
	get_tree().change_scene_to_file(target_scene)

	# Fade in será chamado automaticamente após a troca
	Fade.fade_in()
