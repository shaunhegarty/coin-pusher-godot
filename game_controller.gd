extends Node

signal coin_spawned
signal coin_counted
signal coins_in_play_changed

var coin_count: int = 0
var coins_in_play: int = 0


func _ready():
	coin_spawned.connect(increment_coin_count)


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
