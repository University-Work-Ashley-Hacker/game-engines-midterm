extends Node
class_name LerpComponent2D

@export var display: Node2D
@export var move_to: Node2D
@export var lerp_speed: float = 20

@export var position: bool = true
@export var rotation: bool = false

func _ready() -> void:
	display.top_level = true
	if position: display.global_position = move_to.global_position

func _physics_process(delta: float) -> void:
	if position: display.global_position = display.global_position.lerp(move_to.global_position, delta * lerp_speed)
	#if rotation: display.global_rotation = display.global_rotation.lerp(move_to.global_rotation, delta * lerp_speed)
