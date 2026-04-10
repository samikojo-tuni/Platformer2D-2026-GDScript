class_name Tutorial extends Area2D

@onready var _tutorial_control: Control = $Control

func _ready() -> void:
	_tutorial_control.hide()


func _on_body_entered(body: Node2D) -> void:
	if body is Knight:
		_tutorial_control.show()


func _on_body_exited(body: Node2D) -> void:
	if body is Knight:
		_tutorial_control.hide()
