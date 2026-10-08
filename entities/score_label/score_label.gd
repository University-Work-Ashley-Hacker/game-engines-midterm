class_name ScoreLabel extends Label

@export_category("Paramaters")

@export_category("External Dependencies")

@export_group("Node Dependencies")

@export_group("Component Dependencies")

func _ready() -> void:
	Global.score_changed.connect(_on_score_changed)

func _on_score_changed() -> void:
	text = "Score: " + str(Global.score)
