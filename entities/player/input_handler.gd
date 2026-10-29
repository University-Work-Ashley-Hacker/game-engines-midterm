class_name InputHandler
extends Node

@export var avaliable_ids: Array[PlayerID]
var player_ids: Array[PlayerID]

var registered_deviced_dict: Dictionary[int, PlayerID]

func _ready() -> void:
	player_ids = avaliable_ids

func _print(text: String) -> void:
	print_rich("[b][color=purple]InputHandler: [/color][/b]" + text)

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("start"):
		if not is_registered(event.device):
			try_register_device_to_player(event.device)
	
	if not is_registered(event.device): return
	
	var axis: float
	if event.device == 16: axis = get_key_axis(KEY_A, KEY_D)
	else: axis = get_stick_axis(event.device, JOY_AXIS_LEFT_X)
	
	registered_deviced_dict[event.device].input_move_event.emit(axis)
	
	
	if event.is_action_pressed("bubble"):
		registered_deviced_dict[event.device].input_bubble_event.emit()
	elif event.is_action_pressed("jump"):
		registered_deviced_dict[event.device].input_jump_event.emit()

#region Device Registration
func is_registered(device_id: int) -> bool:
	return registered_deviced_dict.has(device_id)

func try_register_device_to_player(device: int) -> bool:
	if avaliable_ids.size() <= 0:
		_print("No remaining Player IDs")
		return false
	
	var id_to_register: PlayerID = avaliable_ids.pop_front()
	registered_deviced_dict.get_or_add(device, id_to_register)
	id_to_register.device = device
	_print("Sucessfully registered Device [{device}] to [{player}]".format({"device": device, "player": id_to_register}))
	return true
#endregion


#region GetAxis replacement
func get_stick_axis(device: int, axis: JoyAxis, deadzone: float = 0.2) -> float:
	var value: float = Input.get_joy_axis(device, axis)
	return 0.0 if absf(value) < deadzone else value

func get_key_axis(negative_key: Key, positive_key: Key) -> float:
	var negative: float = 1.0 if Input.is_physical_key_pressed(negative_key) else 0.0
	var positive: float = 1.0 if Input.is_physical_key_pressed(positive_key) else 0.0
	return positive - negative
#endregion
