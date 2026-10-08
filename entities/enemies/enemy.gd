class_name Enemy
extends CharacterBody2D

var bubbled: bool = false
@export var bubble_timer: Timer

func _ready() -> void:
	bubble_timer.timeout.connect(_on_bubble_timer_timeout)

func bubble() -> void:
	bubble_timer.start()


func _on_bubble_timer_timeout() -> void:
	return
