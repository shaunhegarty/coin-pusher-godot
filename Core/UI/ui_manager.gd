class_name UiManager extends CanvasLayer

@export var coin_count_label: Label
@export var coins_in_play_label: Label
@export var collect_state_button: Button
@export var reload_state_button: Button
@export var collect_state_for_level_spinner: SpinBox
@export var reload_state_for_level_spinner: SpinBox


# Called when the node enters the scene tree for the first time.
func _ready():
	GameController.coin_counted.connect(update_coin_count)
	GameController.coins_in_play_changed.connect(update_coins_in_play)
	GameController.level_count_changed.connect(update_level_spinners)

	if not GameController.is_registration_complete:
		print("Nearly Ready")
		await GameController.registration_complete
		print("Registration Complete")

	collect_state_button.pressed.connect(GameController.store_game_state)
	reload_state_button.pressed.connect(GameController.new_game)

	update_level_spinners()

	collect_state_for_level_spinner.value_changed.connect(GameController.set_level_to_save)
	reload_state_for_level_spinner.value_changed.connect(GameController.set_level_to_load)

	if OS.has_feature("web"):
		collect_state_button.hide()
		collect_state_for_level_spinner.hide()


func update_level_spinners():
	collect_state_for_level_spinner.max_value = GameController.level_count + 1
	reload_state_for_level_spinner.max_value = GameController.level_count


func update_coin_count():
	coin_count_label.text = "Coins Spawned: %s" % GameController.coin_count


func update_coins_in_play():
	coins_in_play_label.text = "Coins In Play: %s" % GameController.coins_in_play
