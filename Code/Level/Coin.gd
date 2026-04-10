class_name Coin extends Collectable

@onready var audio_stream_player_2d: AudioStreamPlayer2D = $AudioStreamPlayer2D
@onready var gpu_particles_2d: GPUParticles2D = $GPUParticles2D
@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D


@export var _score: int = 10

var _effect_count = 0

func collect(knight : Knight) -> bool:
	if not super.collect(knight):
		return false
	
	# Add score to the game manager
	GameManager.add_score(_score)
	
	return true

# Overwrite the clear to prevent audio from not playing after collecting 
# the coin.
func clear() -> void:
	if audio_stream_player_2d == null:
		super.clear()
		return
	
	# Hide the coin
	animated_sprite_2d.hide()
	
	if audio_stream_player_2d != null:
		audio_stream_player_2d.play()
		audio_stream_player_2d.finished.connect(_on_effect_finished)
		_effect_count += 1
	
	if gpu_particles_2d != null:
		gpu_particles_2d.emitting = true
		gpu_particles_2d.finished.connect(_on_effect_finished)
		_effect_count += 1
	
func _on_effect_finished() -> void:
	_effect_count -= 1
	
	# Destroy the node only when all effects have stopped playing.
	if _effect_count <= 0:
		queue_free()
