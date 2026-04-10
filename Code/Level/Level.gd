class_name Level extends Node2D

@onready var knight: Knight = $Knight
@onready var healthbar: Healthbar = $CanvasLayer/Healthbar

# Ritarin aloituspiste
var _spawn_point : Vector2 = Vector2.ZERO


func _ready() -> void:
	GameManager.register_current_level(self)
	healthbar.setup(knight.health)
	
	# Aseta ritarin aloituspiste
	_spawn_point = knight.global_position

func respawn_knight() -> void:
	knight.global_position = _spawn_point
