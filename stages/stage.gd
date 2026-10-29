class_name Stage extends Node2D

signal stage_complete

@export_category("Dependencies")
@export var spawns: Array[Marker2D]

var enemy_count: int = 0
var enemies_left: int = 0

@onready var environment: Node2D = $Environment
@onready var enemies: Node2D = $Enemies

func _ready() -> void:
	for n in enemies.get_children():
		if n is Enemy:
			n.popped.connect(_on_enemy_popped)
			enemy_count += 1
	
	enemies_left = enemy_count

func enter_tween() -> void:
	var tween: Tween = create_tween()
	tween.set_ease(Tween.EASE_OUT).set_trans(Tween.TRANS_SINE)
	
	tween.tween_property(self, "position:y", 0, 1).from(1080)
	await tween.finished

func exit_tween() -> void:
	var tween: Tween = create_tween()
	tween.set_ease(Tween.EASE_OUT).set_trans(Tween.TRANS_SINE)
	
	tween.tween_property(self, "position:y", -1080, 1).from(0)

func _on_enemy_popped() -> void:
	enemies_left -= 1
	
	if enemies_left <= 0:
		stage_complete.emit()
