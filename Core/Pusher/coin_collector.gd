class_name CoinCollector extends Area3D


# Called when the node enters the scene tree for the first time.
func _ready():
	body_entered.connect(collect_coin)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func collect_coin(body: Node):
	if body.is_in_group("coin"):
		GameController.coin_collected.emit()
