class_name CoinSpawner extends Area3D

@export var coin_scene: PackedScene
@export var collision_shape: CollisionShape3D
var box_shape: BoxShape3D

# Called when the node enters the scene tree for the first time.
func _ready():
	box_shape = collision_shape.shape


func random_spawn_position():
	var limits = box_shape.size
	var shape_position = collision_shape.global_position - limits / 2
	return Vector3(
		shape_position.x + randf() * limits.x, 
		shape_position.y + randf() * limits.y, 
		shape_position.z + randf() * limits.z
		)


func _on_input_event(_camera:Node, event:InputEvent, _position:Vector3, _normal:Vector3, _shape_idx:int):
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT:
		for i in range(10):
			var coin = coin_scene.instantiate()
			add_child(coin)
			coin.global_position = random_spawn_position()


