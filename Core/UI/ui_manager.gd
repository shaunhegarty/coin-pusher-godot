class_name UiManager extends CanvasLayer

@export var coin_count_label: Label
@export var coins_in_play_label: Label
@export var collect_state_button: Button
@export var reload_state_button: Button


# Called when the node enters the scene tree for the first time.
func _ready():
	GameController.coin_counted.connect(update_coin_count)
	GameController.coins_in_play_changed.connect(update_coins_in_play)
	GameController.game_state_stored.connect(enable_coin_reload)

	if not GameController.is_registration_complete:
		print("Nearly Ready")
		await GameController.registration_complete
		print("Registration Complete")

	collect_state_button.pressed.connect(GameController.store_game_state)
	reload_state_button.pressed.connect(GameController.load_stored_game_state)



func update_coin_count():
	coin_count_label.text = "Coins Spawned: %s" % GameController.coin_count


func update_coins_in_play():
	coins_in_play_label.text = "Coins In Play: %s" % GameController.coins_in_play


func enable_coin_reload():
	print("enable coin reload")
	reload_state_button.disabled = false
