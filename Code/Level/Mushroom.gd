class_name Mushroom extends Area2D

@export var _damage: int = 1

func _on_body_entered(body: Node2D) -> void:
	if body is Knight:
		var knight : Knight = body as Knight
		knight.health.take_damage(_damage)
