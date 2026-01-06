extends CanvasLayer

@onready var label: Label = $Label

func _process(_delta):
	label.text = "Madeiras: %d / %d" % [
		GameManager.wood_delivered,
		GameManager.max_wood
	]
