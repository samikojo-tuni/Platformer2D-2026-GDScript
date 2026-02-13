extends Node
class_name Hello

var _frameIndex : int = 0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	print("Hello, World!")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	_frameIndex += 1
	print(_frameIndex)
