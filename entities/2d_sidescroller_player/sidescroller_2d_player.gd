extends CharacterBody2D


@export var move_component: MoveComponent2D
@export var stat_component: StatComponent
@export var health_component: HealthComponent
@export var respawn_point: Marker2D
@export var pop_area: Area2D
@export var pop_col: CollisionShape2D

@export var player_2: bool = false
@export var left_action: String = "p1_left"
@export var right_action: String = "p1_right"
@export var jump_action: String = "p1_a"
@export var shoot_action: String = "p1_b"

var speed: float = 0
var jump_vel: float = 0

var bubble_dir: float = 0

func _input(event: InputEvent) -> void:
	if event.is_action_pressed(jump_action):
		_jump()
	elif event.is_action_pressed(shoot_action):
		_shoot()

func _ready() -> void:
	speed = stat_component.stats["move_speed"]
	jump_vel = stat_component.stats["jump_velocity"]
	health_component.health_depleted.connect(_player_died)
	pop_area.body_entered.connect(_on_pop_body_entered)

func _physics_process(delta: float) -> void:
	if not is_on_floor():
		move_component.velocity += get_gravity() * delta

	var direction := Input.get_axis(left_action, right_action)
	if direction == 1 or direction == -1:
		bubble_dir = direction
	if direction:
		move_component.velocity.x = direction * speed
	else:
		move_component.velocity.x = move_toward(velocity.x, 0, speed)


func _jump() -> void:
	if is_on_floor():
		move_component.velocity.y = jump_vel
		

func _shoot() -> void:
	BubbleFactory.create_bubble(bubble_dir, position, player_2)


func _player_died() -> void:
	if stat_component.stats["lives"] > 0:
		stat_component.stats["lives"] -= 1
		_respawn_player()
	else:
		queue_free()

func _respawn_player() -> void:
	global_position = respawn_point.global_position


func _on_pop_body_entered(body: Node2D) -> void:
	if body is Bubble:
		body.pop()
