extends Node

# Spawn do player ao trocar de cena
var spawn_position: Vector2 = Vector2.ZERO

# ===== OBJETIVO =====
var wood_delivered: int = 0
var max_wood: int = 5


# ===== SISTEMA DE OBJETIVO =====
enum QuestState {
	NONE,
	GET_WOOD,
	DELIVER_WOOD,
	COMPLETED
}

var quest_state: QuestState = QuestState.GET_WOOD
var has_wood: bool = false
