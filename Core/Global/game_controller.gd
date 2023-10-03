extends Node

signal coin_spawned
signal coin_counted
signal coins_in_play_changed
signal game_state_stored

signal node_registered(registered_node)
signal registration_complete


var coin_count: int = 0
var coins_in_play: int = 0

var animation_player: AnimationPlayer
var coins_in_play_area: CoinsInPlayArea
var coin_spawner: CoinSpawner

var is_registration_complete: bool = false


func _ready():
	coin_spawned.connect(increment_coin_count)
	node_registered.connect(_registration_check)


func register_animation_player(pusher_animation_player: AnimationPlayer):
	animation_player = pusher_animation_player
	node_registered.emit(animation_player)


func register_coins_in_play_area(coins_in_play_area_to_register: CoinsInPlayArea):
	coins_in_play_area = coins_in_play_area_to_register
	node_registered.emit(coins_in_play_area)


func register_coin_spawner(coin_spawner_to_register: CoinSpawner):
	coin_spawner = coin_spawner_to_register
	node_registered.emit(coin_spawner)


func _registration_check(registered_node):
	print("Registration Check: %s" % registered_node.name)
	if animation_player and coins_in_play_area and coin_spawner:
		print("Registration Complete")
		registration_complete.emit()
		is_registration_complete = true


func reset():
	coin_count = 0


func increment_coin_count():
	coin_count += 1
	coin_counted.emit()


func increment_coins_in_play():
	coins_in_play += 1
	coins_in_play_changed.emit()


func decrement_coins_in_play():
	coins_in_play -= 1
	coins_in_play_changed.emit()


var base_path = "Assets/Levels/"

func get_level_path(number: int):
	return "%sgame_%d.tres" % [base_path, number]


func store_game_state():
	var game_state = GameState.new()
	game_state.animation_time = animation_player.current_animation_position
	for coin in coins_in_play_area.coins_in_play:
		game_state.coin_positions.append(coin.global_position)
		game_state.coin_rotations.append(coin.global_rotation)

	var save_status = ResourceSaver.save(game_state, get_level_path(1))
	print(save_status)
	game_state_stored.emit()


func load_stored_game_state():
	var game_state = ResourceLoader.load(get_level_path(1))
	coin_spawner.load_coins(game_state)
	animation_player.play("RESET")
	animation_player.seek(game_state.animation_time, true)
	animation_player.play("pusher_motion", 5)