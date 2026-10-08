@tool
class_name DevBlock extends StaticBody2D

@export var size: Vector2 = Vector2(64.0, 64.0):
	set(value):
		size = value
		_update_shape()

@export var color: Color = Color.GRAY:
	set(value):
		color = value
		_update_shape()

func _ready() -> void:
	_update_shape()

func _update_shape() -> void:
	if not is_inside_tree():
		return
	var rect: ColorRect = $ColorRect as ColorRect
	var shape_node: CollisionShape2D = $CollisionShape2D as CollisionShape2D
	if rect == null or shape_node == null:
		return
	rect.size = size
	rect.position = -size / 2.0
	rect.color = color
	var rect_shape: RectangleShape2D = RectangleShape2D.new()
	rect_shape.size = size
	shape_node.shape = rect_shape
