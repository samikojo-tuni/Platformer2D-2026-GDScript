extends Node

# Signals
# score_changed is triggered when the score changes
signal score_changed(new_score : int)

# Player's score in this session
var _score : int = 0

func reset() -> void:
	set_score(0)
	
func add_score(amount: int) -> void:
	# Only a positive amount can be added to the score
	if amount > 0:
		set_score(_score + amount)
	
func get_score() -> int:
	return _score

func set_score(new_score : int) -> void:
	# Validate the new_score before setting it
	_score = max(new_score, 0)
	# Emit a signal every time the score is updated.
	score_changed.emit(_score)
	
