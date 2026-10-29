extends Node

var level_uid_dict: Dictionary[int, String]

signal stage_changed(id: int)
var current_stage: Stage
var current_level: int = 0

@onready var stage_parent: Node2D = $"../Main/Stage"
@onready var pickup_factory: PickupFactory = $"../Main/Management/PickupFactory"

var last_stage: Stage

func _print(text: String) -> void:
	print_rich("[b][color=yellow]GameManager: [/color][/b]" + text)

func _ready() -> void:
	_setup_stage_dict()
	
	load_level(current_level)

func _setup_stage_dict() -> void:
	level_uid_dict.get_or_add(0, "uid://da2mb7denvrv8")
	level_uid_dict.get_or_add(1, "uid://def7sroo87q1")
	level_uid_dict.get_or_add(2, "uid://7e6swglsbosr")

func load_level(id: int) -> void:
	if not level_uid_dict.has(id):
		_print("No next level")
		return
	
	
	var dort: bool = false
	if current_stage: 
		current_stage.exit_tween()
		last_stage = current_stage
	else:
		dort = true
	
	
	# Create scene below current one
	var scene: PackedScene = load(level_uid_dict[id])
	var instance := scene.instantiate() as Stage
	current_stage = instance
	
	# Setup stage intro tween
	if not dort: 
		current_stage.position.y = 1920
		stage_parent.add_child.call_deferred(current_stage)
		current_stage.enter_tween()
		await get_tree().create_timer(1).timeout
	else:
		stage_parent.add_child.call_deferred(current_stage)
	
	
	# Add child
	current_stage.stage_complete.connect(_on_stage_complete, CONNECT_ONE_SHOT)
	stage_changed.emit(id)
	get_tree().call_group("bubble", "pop")

func get_spawn(player_id: int) -> Marker2D:
	return current_stage.spawns[player_id - 1]

func get_random_floor_space() -> Vector2:
	var from: Vector2 = get_random_screen_space()
	var to: Vector2 = Vector2(from.x, from.y +2000)
	var query: PhysicsRayQueryParameters2D = PhysicsRayQueryParameters2D.create(from, to)
	query.collision_mask = 1 << 0  # layer 3 only
	var hit: Dictionary = stage_parent.get_world_2d().direct_space_state.intersect_ray(query)
	if not hit.is_empty():
		return hit["position"] as Vector2
	_print("Raycast failed, hit.is_empty() returned true")
	return Vector2.ZERO
	

func get_random_screen_space() -> Vector2:
	var random := Vector2(randf_range(0, get_viewport().get_visible_rect().size.x), randf_range(0, get_viewport().get_visible_rect().size.y))
	#_print(str(random))
	return random


func change_level() -> void:
	current_level += 1
	load_level(current_level)
	await stage_changed
	unload_last_level()

func _on_stage_complete() -> void:
	change_level()
	

func create_random_pickup(pos: Vector2) -> void:
	pickup_factory.create_pickup(pos)

func unload_last_level() -> void:
	last_stage.queue_free()
