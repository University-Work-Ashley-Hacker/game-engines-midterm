extends Node

signal score_changed

@export_category("External Dependencies")

@export_group("Node Dependencies")

@export_group("Component Dependencies")

var score: int = 0

func add_score(amount: int) -> void:
	score += amount
	score_changed.emit()
