extends Sprite2D
class_name ProtoMover

#region Godot member variables
@export var _direction : Vector2 = Vector2.ZERO
@export var _speed : float = 5
@export var _bounce_between : bool = false
@export var _point1 : Node2D = null
@export var _point2 : Node2D = null
@export var _destination_margin : float = 5
#endregion

var _target : Node2D = null

func _ready() -> void:
	_direction = _direction.normalized()
	
	if _bounce_between:
		global_position = _point1.global_position
		toggle_target()

func _process(delta: float) -> void:
	if _bounce_between:
		if bounce_between(delta):
			toggle_target()
	else:
		move_direction(delta)

## Moves between two points. Returns true, if the current target is reached.
func bounce_between(delta: float) -> bool:
	# Vektori nykyisestä sijainnista kohdepisteen sijaintiin
	var to_target : Vector2 = _target.global_position - global_position
	var movement_direction : Vector2 = to_target.normalized()
	var movement : Vector2 = movement_direction * _speed * delta
	global_translate(movement)
	
	return (_target.global_position - global_position).length() < _destination_margin

func move_direction(delta: float) -> void:
	var point : Vector2 = global_position
	point += _direction * _speed * delta
	global_position = point

func toggle_target() -> void:
	if _target == _point2:
		_target = _point1
	else:
		_target = _point2
