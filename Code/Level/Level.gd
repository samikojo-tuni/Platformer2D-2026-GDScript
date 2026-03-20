class_name Level extends Node2D

@onready var knight: Knight = $Knight
@onready var healthbar: Healthbar = $CanvasLayer/Healthbar


func _ready() -> void:
	GameManager.register_current_level(self)
	healthbar.setup(knight.health)
