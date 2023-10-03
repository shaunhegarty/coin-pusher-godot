class_name UiManager extends CanvasLayer

@export var coin_count_label: Label
@export var coins_in_play_label: Label


# Called when the node enters the scene tree for the first time.
func _ready():
	GameController.coin_counted.connect(update_coin_count)
	GameController.coins_in_play_changed.connect(update_coins_in_play)


func update_coin_count():
	coin_count_label.text = "Coins Spawned: %s" % GameController.coin_count


func update_coins_in_play():
	coins_in_play_label.text = "Coins In Play: %s" % GameController.coins_in_play
