extends Node
class_name Fibonacci

#region Member variables
var _previous : int = 0
var _current : int = 1
var _frameIndex : int = 0
#endregion

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	if _previous > 1000:
		return
	
	_frameIndex += 1
	#print("Frame ", _frameIndex, ": ", _previous)
	#print("Frame " + str(_frameIndex) + ": " + str(_previous))
	print("Frame %s: %s" % [str(_frameIndex), str(_previous)])
	
	var next : int = _previous + _current
	_previous = _current
	_current = next
