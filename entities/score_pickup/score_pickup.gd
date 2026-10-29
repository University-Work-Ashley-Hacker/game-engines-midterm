class_name ScorePickup extends CharacterBody2D

@export var sprite: CompressedTexture2D
@export var points: int = 500

@export var _area: Area2D
@export var _sprite_2d: Sprite2D
@export var _move_component: MoveComponent2D

var grabbed: bool = false

var setup: bool = false

func set_sprite(new_sprite: CompressedTexture2D) -> void:
	sprite = new_sprite
	_sprite_2d.texture = sprite

func _ready() -> void:
	_area.body_entered.connect(_on_body_entered)
	await get_parent().ready
	setup = true

func _on_body_entered(body: Node2D) -> void:
	if body is Player:
		if grabbed: return # Prevents 2 people picking something up on the same frame
		grabbed = true
		player_picked_up(body.player_id)

func _process(delta: float) -> void:
	var grav: float = get_gravity().y
	
	_move_component.velocity.y += grav * delta

func player_picked_up(player: PlayerID) -> void:
	player.score += points
	call_deferred("queue_free")
