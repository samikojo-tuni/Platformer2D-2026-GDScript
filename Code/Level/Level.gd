class_name Level extends Node2D

# TODO: Extend this class's functionality

@onready var knight: Knight = $Knight

func _ready() -> void:
	GameManager.register_current_level(self)
