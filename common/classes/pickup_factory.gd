class_name PickupFactory extends Node2D

@export var pickup_scene: PackedScene
@export var main_pickup_pool: PickupPool
@export var pickup_parent: Node2D

func create_pickup(pos: Vector2) -> void:
	var instance := pickup_scene.instantiate() as ScorePickup
	var points: int = main_pickup_pool.pickups.keys().pick_random()
	instance.points = points
	instance.set_sprite(main_pickup_pool.pickups[points])
	pickup_parent.add_child(instance)
	instance.global_position = pos
