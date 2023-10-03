extends Node

signal coin_spawned
signal coin_counted
signal coins_in_play_changed

var coin_count: int = 0
var coins_in_play: int = 0

var animation_player: AnimationPlayer
var coins_in_play_area: CoinsInPlayArea


func _ready():
	coin_spawned.connect(increment_coin_count)


func register_animation_player(pusher_animation_player: AnimationPlayer):
	animation_player = pusher_animation_player


func register_coins_in_play_area(coins_in_play_area_to_register: CoinsInPlayArea):
	coins_in_play_area = coins_in_play_area_to_register


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


var stored_game_state: GameState


func store_game_state():
	var game_state = GameState.new()
	game_state.animation_time = animation_player.current_animation_position
	for coin in coins_in_play_area.coins_in_play:
		game_state.coin_positions.append(coin.global_position)
		game_state.coin_rotations.append(coin.global_rotation)

	stored_game_state = game_state