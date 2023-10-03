class_name CoinSpawner extends Area3D

@export var coin_scene: PackedScene
@export var collision_shape: CollisionShape3D
var box_shape: BoxShape3D

var spawned_coins: Array[RigidBody3D] = []


# Called when the node enters the scene tree for the first time.
func _ready():
	box_shape = collision_shape.shape
	GameController.register_coin_spawner(self)


func random_spawn_position():
	var limits = box_shape.size
	var shape_position = collision_shape.global_position - limits / 2
	return Vector3(
		shape_position.x + randf() * limits.x,
		shape_position.y + randf() * limits.y,
		shape_position.z + randf() * limits.z
	)


func spawn_coin_randomly():
	var spawn_position = random_spawn_position()
	var coin = coin_scene.instantiate()
	add_child(coin)
	coin.global_position = spawn_position
	GameController.coin_spawned.emit()


func spawn_coin(spawn_position: Vector3, spawn_rotation: Vector3):
	var coin = coin_scene.instantiate()
	add_child(coin)
	coin.global_position = spawn_position
	coin.global_rotation = spawn_rotation
	GameController.coin_spawned.emit()


func load_coins(state: GameState):
	delete_all_coins()
	var size = state.coin_positions.size()
	for i in range(size):
		spawn_coin(state.coin_positions[i], state.coin_rotations[i])


func delete_all_coins():
	get_tree().call_group("coin", "queue_free")


func _on_input_event(
	_camera: Node, event: InputEvent, _position: Vector3, _normal: Vector3, _shape_idx: int
):
	if event is InputEventMouseButton and event.pressed:
		if event.button_index == MOUSE_BUTTON_LEFT:
			for i in range(10):
				spawn_coin_randomly()
		if event.button_index == MOUSE_BUTTON_RIGHT:
			delete_all_coins()
