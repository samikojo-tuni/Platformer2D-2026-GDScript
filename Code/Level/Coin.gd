class_name Coin extends Collectable

@export var _score: int = 10

func collect(knight : Knight) -> bool:
	if not super.collect(knight):
		return false
	
	# Add score to the game manager
	GameManager.add_score(_score)
	
	return true
