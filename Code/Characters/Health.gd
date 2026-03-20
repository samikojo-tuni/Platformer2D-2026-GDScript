class_name Health extends Node

signal health_changed(previous_health: int, current_health: int)

@export var max_health : int = 3

var _current_health : int = 0

# Is the character immortal at the moment.
var is_immortal : bool = false
 
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	reset()

func get_current_health() -> int:
	return _current_health
	
func set_current_health(value: int) -> void:
	var previous_health: int = _current_health
	
	# Makes sure the value is always between 0 and max_health.
	_current_health = clamp(value, 0, max_health)
	
	# Notify interested parties about health value's change
	health_changed.emit(previous_health, _current_health)
	
func take_damage(amount: int) -> bool:
	if amount < 0:
		return false
	
	set_current_health(_current_health - amount)
	return true

func heal(amount: int) -> bool:
	if amount < 0:
		return false
	
	set_current_health(_current_health + amount)
	return true

func reset() -> void:
	set_current_health(max_health)
