class_name PlayerID
extends Resource

@warning_ignore("unused_signal")
signal input_move_event(axis: float)
@warning_ignore("unused_signal")
signal input_jump_event
@warning_ignore("unused_signal")
signal input_bubble_event

signal score_changed(new_score: int)

@export var sprite: CompressedTexture2D
@export var name: String
@export var color: Color
@export var id: int
var device: int = -10
var lives: int = 3
var score: int = 0:
	get:
		return score
	set(value):
		if score == value: return
		score = value
		score_changed.emit(score)
