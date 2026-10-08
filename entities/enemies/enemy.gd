class_name Enemy
extends CharacterBody2D

var bubbled: bool = false
var in_bubble: Bubble
@export var hitbox: HitboxComponent2D
@export var hurtbox: HurtboxComponent2D
@export var col: CollisionShape2D

@export var bubble_timer: Timer

func _ready() -> void:
	bubble_timer.timeout.connect(_on_bubble_timer_timeout)

func _physics_process(delta: float) -> void:
	if in_bubble:
		position = in_bubble.position

func bubble(bub: Bubble) -> void:
	bubble_timer.start()
	bubbled = true
	in_bubble = bub
	hitbox.active = false
	hurtbox.set_deferred("active", true)
	col.set_deferred("disabled", true)

func unbubble() -> void:
	bubbled = false
	in_bubble = null
	hurtbox.active = false
	hitbox.set_deferred("active", true)
	col.set_deferred("disabled", false)

func pop() -> void:
	Global.add_score(50)
	queue_free()

func _on_bubble_timer_timeout() -> void:
	unbubble()
