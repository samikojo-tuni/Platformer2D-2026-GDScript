class_name FollowCamera extends Camera2D

@export var target : Node2D = null
@export var speed : float = 5

func _ready() -> void:
	if target == null:
		push_warning("FollowCamera: The target is not set!")

func _process(delta: float) -> void:
	if target == null:
		return
		
	if process_callback == Camera2DProcessCallback.CAMERA2D_PROCESS_IDLE:
		_update_position(delta)

func _physics_process(delta: float) -> void:
	if target == null:
		return
		
	if process_callback == Camera2DProcessCallback.CAMERA2D_PROCESS_PHYSICS:
		_update_position(delta)
		
func _update_position(delta: float) -> void:
	var target_position : Vector2 = target.global_position
	var current_position : Vector2 = global_position
	# Camera's new position
	global_position = current_position.lerp(target_position, speed * delta)
