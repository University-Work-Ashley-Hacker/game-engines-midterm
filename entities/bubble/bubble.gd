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
@export var bubble_hitbox: Area2D
@export var bubble_hitbox_col: CollisionShape2D
@export var contained_enemy: Enemy

var can_be_popped: bool = false
var floating: bool = false
var speed: float
var float_speed: float

func  _ready() -> void:
	#area_entered.connect(_on_body_entered)
	speed = stat_component.stats["move_speed"]
	float_speed = stat_component.stats["float_speed"]
	initial_bubble_timer.timeout.connect(_initial_bubble_timout)
	bubble_hitbox.body_entered.connect(_on_body_entered)

func _on_body_entered(body: Node2D) -> void:
	if body is Enemy:
		body.bubble(self)
		contained_enemy = body

func pop() -> void:
	if not can_be_popped: return
	if contained_enemy:
		contained_enemy.pop()
	queue_free()

func _physics_process(delta: float) -> void:
	if not floating:
		move_component.velocity.x = speed * dir
	else:
		move_component.velocity.y = -float_speed


func _initial_bubble_timout() -> void:
	move_component.velocity.x = 0
	can_be_popped = true
	dir = 0
	floating = true
	bubble_hitbox_col.set_deferred("disabled", true)
