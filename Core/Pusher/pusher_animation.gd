extends AnimationPlayer


# Called when the node enters the scene tree for the first time.
func _ready():
	GameController.register_animation_player(self)
	play("pusher_motion")
