extends CharacterBody2D
class_name Knight

@export var _speed : float = 100
@export var _jump_velocity : float = 200
@onready var _animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D

#region Input variables
var _horizontal_input : float = 0
var _is_jumping : bool = false
#endregion

#region Godot functionality
func _input(event: InputEvent) -> void:
	if event.is_action_pressed("Jump"):
		_is_jumping = true

func _process(_delta: float) -> void:
	# Syötteen luvun viiveen minimoimiseksi luetaan syöte täällä
	_horizontal_input = Input.get_axis("MoveLeft", "MoveRight")
	
func _physics_process(delta: float) -> void:
	# 1. Lisää painovoima
	_apply_gravity(delta)
	
	# 2. Reagoi hyppyyn
	_handle_jump()
	
	# 3. Reagoi liikkeeseen
	_handle_move()
	
	# 4. Päivitä animaatiot
	# TODO: Implement me!
	_update_animations()
	
	# 5. Väiltä tiedot fysiikkamoottorille
	move_and_slide()
#endregion

#region Internal functionality
func _apply_gravity(delta : float) -> void:
	if not is_on_floor():
		velocity += get_gravity() * delta

func _handle_jump() -> void:
	if _is_jumping and is_on_floor():
		velocity.y = -_jump_velocity
		# "Käytä" hyppyinput
		_is_jumping = false

func _handle_move() -> void:
	# 1. Jos syöte on olemassa, eli ei 0, liiku syötteen mukaisesti
	# 2. Jos syötettä ei ole, hidasta vauhtia tasaisesti, älä pysähdy kuin seinään
	if is_zero_approx(_horizontal_input):
		# Hidasta nopeutta
		velocity.x = move_toward(velocity.x, 0, _speed)
	else:
		velocity.x = _horizontal_input * _speed
		# Käänny katsomaan kulkusuuntaan
		_animated_sprite_2d.flip_h = velocity.x < 0
		
func _update_animations() -> void:
	# Ritarin tilasta riippuen, toista joko
	# * idle
	# * move
	# * tai jump
	pass
#endregion
