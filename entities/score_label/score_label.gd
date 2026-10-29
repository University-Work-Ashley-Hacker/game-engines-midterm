class_name ScoreLabel extends Label

@export var player_id: PlayerID

func _ready() -> void:
	player_id.score_changed.connect(_on_score_changed)

func _on_score_changed(score: int) -> void:
	text = "Score: " + str(score)
