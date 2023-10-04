class_name GameInfo extends PanelContainer

@export var pocket_value: Label
@export var spent_value: Label
@export var earned_value: Label
@export var profit_value: Label


func _ready():
	GameController.coin_spawned.connect(update_info)
	GameController.coins_in_play_changed.connect(update_info)


# Called when the node enters the scene tree for the first time.
func update_info():
	var game = GameController.game
	pocket_value.text = "%sp" % game.pocket
	spent_value.text = "%sp" % game.spent
	earned_value.text = "%sp" % game.collected
	profit_value.text = "%sp" % game.profit()
