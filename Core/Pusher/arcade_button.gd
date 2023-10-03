class_name ArcadeButton extends Node3D

signal arcade_button_pressed

@export var button_animation_player: AnimationPlayer


# Called when the node enters the scene tree for the first time.
func _ready():
	pass  # Replace with function body.


func _on_area_3d_input_event(
	_camera: Node, event: InputEvent, _position: Vector3, _normal: Vector3, _shape_idx: int
):
	if event is InputEventMouseButton:
		if event.pressed and event.button_index == MOUSE_BUTTON_LEFT:
			button_animation_player.play("button_press")
			arcade_button_pressed.emit()
		else:
			button_animation_player.play("button_release")
