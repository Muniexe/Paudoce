extends Node

# ===============================
# PLAYER / CENA
# ===============================
var spawn_position: Vector2 = Vector2.ZERO
var hud: Node = null


# ===============================
# OBJETIVO: MADEIRA
# ===============================
var wood_delivered: int = 0
var max_wood: int = 5
var has_wood: bool = false


# ===============================
# ESTADO DA MISSÃO
# ===============================
enum QuestState {
	NONE,
	GET_WOOD,
	DELIVER_WOOD,
	COMPLETED
}

var quest_state: QuestState = QuestState.GET_WOOD


# ===============================
# FUNÇÕES ÚTEIS
# ===============================
func reset_wood_quest():
	wood_delivered = 0
	has_wood = false
	quest_state = QuestState.GET_WOOD


func deliver_wood():
	wood_delivered += 1
	has_wood = false

	if wood_delivered >= max_wood:
		quest_state = QuestState.COMPLETED
	else:
		quest_state = QuestState.GET_WOOD
