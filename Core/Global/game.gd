class_name Game extends RefCounted

@export var coin_value: int = 2
@export var pocket: int = 20
var spent: int = 0
var collected: int = 0

var is_on: bool = false


func spend():
	if pocket > 0:
		pocket -= coin_value
		spent += coin_value


func collect():
	pocket += coin_value
	collected += coin_value


func profit() -> int:
	return collected - spent


func start():
	is_on = true
	GameController.coin_spawned.connect(spend)
	GameController.coin_collected.connect(collect)


func end():
	is_on = false
	GameController.coin_spawned.disconnect(spend)
	GameController.coin_collected.disconnect(collect)


func can_spawn() -> bool:
	return is_on and pocket > 0
