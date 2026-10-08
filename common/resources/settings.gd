class_name Setting extends Resource

@export var property: String
@export var default_value: Variant
var value: Variant:
	get:
		return value
	set(new_value):
		value = new_value
		setting_changed.emit(value)

signal setting_changed(new_value: Variant)

func reset_to_default() -> void:
	value = default_value
