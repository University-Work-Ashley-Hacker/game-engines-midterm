class_name BubbleFactory
extends Node2D

var bubble_scene: PackedScene = load("uid://q6pxj8u1eaa3")

var green_color: Color = "#02ff00"
var blue_color: Color = "#22b5ff"

var bubble_parent: Node2D:
	get:
		if bubble_parent == null:
			bubble_parent = get_tree().get_first_node_in_group("bubble_parent")
		return bubble_parent
	set(value):
		bubble_parent = value

func create_bubble(player: PlayerID, dir: float = 1, spawn_at: Vector2 = Vector2.ZERO,) -> Bubble:
	var instance: Bubble = bubble_scene.instantiate()
	instance.dir = dir
	instance.color = player.color
	instance.color.a = .25
	bubble_parent.add_child(instance)
	instance.position = spawn_at
	instance.player = player
	return instance
	
