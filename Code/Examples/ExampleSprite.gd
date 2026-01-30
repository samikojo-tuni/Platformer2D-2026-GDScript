class_name ExampleSprite # Luokan nimi
extends Sprite2D # Mistä luokasta tämä luokka periytyy

# Jäsenmuuttujat
@export var _speed: float = 10

# Called when the node enters the scene tree for the first time.
# Käytetään Noden alustukseen.
func _ready() -> void:
	print("Sijainti maailman koordinaatistossa: " + str(global_position))
	print("Paikallinen sijainti (suhteessa vanhempaan): " + str(position))
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	# liikutetaan objektia
	# on pikseliä / sekunti eikä pikseliä / frame
	global_position.x += _speed * delta
