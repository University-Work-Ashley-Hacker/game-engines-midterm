@tool
class_name MoveComponent
extends Node

## The node you want to control
@export var actor: Node3D
## Whether or not the movement should be added based on the direction the actor is facing
@export var use_basis: bool = false
## The velocity of the actor
@export var velocity: Vector3

@export_group("Component Dependencies")
@export var stat_component: StatComponent

func _ready() -> void:
	if Engine.is_editor_hint():
		_editor_spawn()

func _editor_spawn() -> void:
	if not stat_component: if has_node("../%StatComponent"): stat_component = $"../%StatComponent"
	unique_name_in_owner = true

func _physics_process(delta: float) -> void:
	if Engine.is_editor_hint(): return
	
	var vel_cal: Vector3
	
	if use_basis:
		vel_cal = actor.transform.basis * velocity * delta
	else:
		vel_cal = velocity * delta
	
	if actor is CharacterBody3D:
		actor.velocity = vel_cal * 50
	else:
		actor.translate(vel_cal)
