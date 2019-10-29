extends Spatial

var smoothness_multiplier = 1.5
var refresh_multiplier = 0.97

var current_refresh_multiplier = 1
var backward_vector = Vector3.BACK
var beginning = Transform(Basis(Vector3.FORWARD, 0), backward_vector + Vector3.ONE / 2)
var new_transform = beginning

onready var game = $"/root/game"

func _ready():
	transform = beginning

func _process(delta):
	if game.game_over or global.interface_to_display != global.DISPLAY_GAMEPLAY:
		return
	var refresh_time = game.default_refresh_time * current_refresh_multiplier
	game.update_timer.set_wait_time(refresh_time)
	new_transform.origin -= backward_vector * delta / refresh_time
	smoothly_move(new_transform, refresh_time * smoothness_multiplier)

func smoothly_move(transform_to, duration):
	game.tween.interpolate_property(self, "transform", transform, transform_to, duration, Tween.TRANS_LINEAR, Tween.EASE_IN)
	game.tween.start()