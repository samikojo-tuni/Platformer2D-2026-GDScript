class_name Goal extends Area2D

@export var next_scene_path : String = "res://"

func _on_body_entered(body: Node2D) -> void:
	if body is Knight:
		GameManager.go_to_scene(next_scene_path)
