class_name KillZone extends Area2D


func _on_body_entered(body: Node2D) -> void:
	if body is Knight:
		var knight : Knight = body as Knight
		knight.health.take_damage(knight.health.get_current_health())
