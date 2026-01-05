extends Area2D

@export var target_scene: String = "res://fases/test/test.tscn"

var player_inside := false
var player_ref: CharacterBody2D


func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		player_inside = true
		player_ref = body
		body.show_interact_icon()


func _on_body_exited(body: Node2D) -> void:
	if body.is_in_group("player"):
		player_inside = false
		player_ref = null
		body.hide_interact_icon()


func _process(_delta: float) -> void:
	if player_inside and Input.is_action_just_pressed("interact"):
		exit_house()


func exit_house() -> void:
	$DoorSound.play()
	
	GameManager.spawn_position = Vector2(263.0, 84.0) # posição do SpawnExit
	Fade.fade_out()
	await get_tree().create_timer(0.25).timeout
	get_tree().change_scene_to_file(target_scene)
	Fade.fade_in()
