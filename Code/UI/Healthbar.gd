class_name Healthbar extends HBoxContainer

const HEART = preload("uid://bbv5jkqu5eajp")
var _hearts : Array[Control] = []

func setup(health: Health) -> void:
	# Create as many hearts as the max health is
	for i in health.max_health:
		var heart : Control = HEART.instantiate() as Control
		add_child(heart)
		_hearts.push_back(heart)
	
	health.health_changed.connect(_on_health_changed)

func _on_health_changed(previous_health : int, current_health : int) -> void:
	for i in _hearts.size():
		_hearts[i].visible = i < current_health
