class_name Bubble extends CharacterBody2D

var color: Color = "#FFFFFF":
	get:
		return color
	set(value):
		visual.modulate = value
		color = value
var dir: float = 0

@export var move_component: MoveComponent2D
@export var stat_component: StatComponent
@export var initial_bubble_timer: Timer
@export var visual: Node2D

var floating: bool = false
var speed: float
var float_speed: float

func  _ready() -> void:
	#area_entered.connect(_on_body_entered)
	speed = stat_component.stats["move_speed"]
	float_speed = stat_component.stats["float_speed"]
	initial_bubble_timer.timeout.connect(_initial_bubble_timout)

func _on_body_entered(body: Node2D) -> void:
	if body is Enemy:
		pass

func _physics_process(delta: float) -> void:
	if not floating:
		move_component.velocity.x = speed * dir
	else:
		move_component.velocity.y = -float_speed


func _initial_bubble_timout() -> void:
	move_component.velocity.x = 0
	dir = 0
	floating = true
