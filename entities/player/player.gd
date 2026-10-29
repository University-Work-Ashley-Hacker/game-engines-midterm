class_name Player
extends CharacterBody2D

@export var player_id: PlayerID

@export var move_component: MoveComponent2D
@export var stat_component: StatComponent
@export var health_component: HealthComponent
@export var respawn_point: Marker2D
@export var pop_area: Area2D
@export var bubble_factory: BubbleFactory
@export var pop_col: CollisionShape2D
@export var sprite_2d: Sprite2D
@export var bubble_cooldown_timer: Timer

var speed: float = 0
var jump_vel: float = 0

var bubble_dir: float = 0

var move_dir: float = 0

var was_on_ceiling: bool

func _ready() -> void:
	speed = stat_component.stats["move_speed"]
	jump_vel = stat_component.stats["jump_velocity"]
	health_component.health_depleted.connect(_player_died)
	pop_area.body_entered.connect(_on_pop_body_entered)
	
	player_id.input_bubble_event.connect(_shoot)
	player_id.input_jump_event.connect(_jump)
	player_id.input_move_event.connect(_on_move)
	
	sprite_2d.texture = player_id.sprite
	
	GameManager.stage_changed.connect(_on_stage_changed)

func _on_move(axis: float) -> void:
	move_dir = axis

func _physics_process(delta: float) -> void:
	var grav := get_gravity()
	if not is_on_floor():
		if move_component.velocity.y > 0.1: grav *= 2
		move_component.velocity += grav * delta
	
	if is_on_ceiling() && not was_on_ceiling:
		was_on_ceiling = true
		_headbonk()
	
	was_on_ceiling = is_on_ceiling()
	
	if move_dir == 1 or move_dir == -1:
		bubble_dir = move_dir
		
		sprite_2d.flip_h = move_dir == -1
		
	if move_dir:
		move_component.velocity.x = move_dir * speed
	else:
		move_component.velocity.x = move_toward(velocity.x, 0, speed)

func _headbonk() -> void:
	move_component.velocity.y = 0

func _jump() -> void:
	if is_on_floor():
		move_component.velocity.y = jump_vel
		

func _shoot() -> void:
	if not bubble_cooldown_timer.is_stopped():
		return
	
	bubble_factory.create_bubble(player_id, bubble_dir, position)
	bubble_cooldown_timer.start()


func _player_died() -> void:
	if player_id.lives > 0:
		player_id.lives -= 1
		_respawn_player()
	else:
		queue_free()

func _respawn_player() -> void:
	global_position = GameManager.get_spawn(player_id.id).global_position


func _on_pop_body_entered(body: Node2D) -> void:
	if body is Bubble:
		body.pop()


func _on_stage_changed(_id: int) -> void:
	_respawn_player()
