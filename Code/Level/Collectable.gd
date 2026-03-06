class_name Collectable extends Area2D

var is_collected : bool = false

func _on_body_entered(body: Node2D) -> void:
	print("Something collided with a collectable")
	if body is Knight:
		if not collect(body as Knight):
			print("Collecting didn't succeed!")

func collect(_knight : Knight) -> bool:
	if is_collected:
		# Esine on jo kerätty, ei mahdollisteta sen keräämistä uudelleen.
		return false
	
	# TODO: Toista keräämiseen liittyvät efektit, kuten ääni ja partikkeli
	
	# Merkitse esine kerätyksi ja poista se pelimaailmasta.
	is_collected = true
	queue_free()
	return true
