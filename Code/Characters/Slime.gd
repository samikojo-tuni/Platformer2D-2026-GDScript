class_name Slime extends Area2D

# The health functionality
@onready var health: Health = $Health
# For animation control
@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D
@onready var damage_timer: Timer = $DamageTimer


@export var bounce_force: float = -200
@export var damage_time: float = 1

var _path_follower : PathFollower = null

func _ready() -> void:
	_path_follower = get_parent() as PathFollower

func _process(_delta: float) -> void:
	if _path_follower != null:
		animated_sprite_2d.flip_h = _path_follower.direction < 0

func _on_take_damage(body: Node2D) -> void:
	if body is Knight:
		var knight : Knight = body as Knight
		# When the knight is immortal, it has just taken damage.
		# To prevent player from misusing this, prevent damaging enemy
		# during this time.
		if knight.health.is_immortal:
			return
		
		# Take damage
		health.take_damage(1)
		
		var bounce_vector: Vector2 = Vector2(0, bounce_force)
		knight.bounce(bounce_vector)


func _on_health_changed(previous_health: int, current_health: int) -> void:
	if current_health == 0:
		_die()
	if current_health < previous_health:
		# Start damage timer
		damage_timer.start(damage_time)
		damage_timer.timeout.connect(_on_timer_timeout)
		health.is_immortal = true
		animated_sprite_2d.play("damage")

func _on_timer_timeout() -> void:
	damage_timer.timeout.disconnect(_on_timer_timeout)
	health.is_immortal = false
	animated_sprite_2d.play("default")

func _die() -> void:
	# TODO: Play animation, sound etc.
	queue_free()

func _on_damage_other(body: Node2D) -> void:
	if body is Knight:
		var knight : Knight = body as Knight
		if knight.health.is_immortal:
			return
		
		knight.health.take_damage(1)
		
		var bounce_vector: Vector2 = Vector2(0, bounce_force)
		knight.bounce(bounce_vector)
