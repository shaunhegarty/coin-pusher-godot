extends Area3D


# Called when the node enters the scene tree for the first time.
func _ready():
	body_entered.connect(coin_in_play)
	body_exited.connect(coin_out_of_play)


func coin_in_play(body: Node) -> void:
	if body.is_in_group("coin"):
		GameController.increment_coins_in_play()


func coin_out_of_play(body: Node) -> void:
	if body.is_in_group("coin"):
		GameController.decrement_coins_in_play()
