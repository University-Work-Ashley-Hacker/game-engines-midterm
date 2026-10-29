class_name Enemy
extends CharacterBody2D

signal popped

var bubbled: bool = false
var in_bubble: Bubble
var dead: bool = false
@export var hitbox: HitboxComponent2D
@export var hurtbox: HurtboxComponent2D
@export var col: CollisionShape2D
@export var move_component: MoveComponent2D

@export var bubble_timer: Timer

func _ready() -> void:
	bubble_timer.timeout.connect(_on_bubble_timer_timeout)

func _physics_process(_delta: float) -> void:
	if in_bubble:
		position = in_bubble.position
	
	if dead: return
	

func bubble(bub: Bubble) -> void:
	bubble_timer.start()
	bubbled = true
	in_bubble = bub
	hitbox.active = false
	hurtbox.set_deferred("active", true)
	col.set_deferred("disabled", true)

func unbubble() -> void:
	print("Unbubble")
	bubbled = false
	if in_bubble: in_bubble.queue_free()
	in_bubble = null
	hurtbox.active = false
	hitbox.set_deferred("active", true)
	col.set_deferred("disabled", false)

func pop() -> void:
	popped.emit()
	if in_bubble: in_bubble.player.score += 50
	
	dead = true
	in_bubble = null
	bubbled = false

	global_position = GameManager.get_random_floor_space()
	
	await get_tree().create_timer(1).timeout
	GameManager.create_random_pickup(global_position)
	queue_free()

func _on_bubble_timer_timeout() -> void:
	unbubble()
