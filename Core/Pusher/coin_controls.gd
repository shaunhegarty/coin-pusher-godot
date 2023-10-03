class_name CoinControls extends Node3D

@export var coin_spawner: CoinSpawner
@export var single_coin_button: ArcadeButton

# Called when the node enters the scene tree for the first time.
func _ready():
	single_coin_button.arcade_button_pressed.connect(coin_spawner.spawn_coin_randomly)