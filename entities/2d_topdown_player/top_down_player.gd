extends CharacterBody2D

@export var move_component: MoveComponent2D
@export var stat_component: StatComponent

var speed: float = 0
var jump_vel: float = 0

func _ready() -> void:
	speed = stat_component.stats["move_speed"]
	jump_vel = stat_component.stats["jump_velocity"]

var input_dir: Vector2 = Vector2.ZERO

func _process(_delta: float) -> void:
	input_dir = Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")

func _physics_process(_delta: float) -> void:
	move_component.velocity = input_dir * speed
