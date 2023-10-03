class_name CoinsInPlayArea extends Area3D

var coins_in_play: Array[Node3D] = []


# Called when the node enters the scene tree for the first time.
func _ready():
	GameController.register_coins_in_play_area(self)
	body_entered.connect(coin_in_play)
	body_exited.connect(coin_out_of_play)


func force_recount():
	coins_in_play.clear()
	GameController.coins_in_play = 0
	for body in get_overlapping_bodies():
		if body.is_in_group("coin"):
			coins_in_play.append(body)
			GameController.increment_coins_in_play(true)


func coin_in_play(body: Node) -> void:
	if body.is_in_group("coin"):
		coins_in_play.append(body)
		GameController.increment_coins_in_play()


func coin_out_of_play(body: Node) -> void:
	if body.is_in_group("coin"):
		coins_in_play.erase(body)
		GameController.decrement_coins_in_play()
