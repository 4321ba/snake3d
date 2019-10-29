extends Node

onready var game = $"/root/game"

func _unhandled_key_input(event):
	if event.is_pressed() and not event.is_echo() and not get_tree().is_paused():
		if InputMap.action_has_event("move_up", event):
			game.snake.turn(Vector3.RIGHT)
		if InputMap.action_has_event("move_down", event):
			game.snake.turn(Vector3.LEFT)
		if InputMap.action_has_event("move_left", event):
			game.snake.turn(Vector3.UP)
		if InputMap.action_has_event("move_right", event):
			game.snake.turn(Vector3.DOWN)
	if Input.is_action_just_pressed("reload"):
		game.reload()
	if Input.is_action_just_pressed("pause"):
		game.toggle_pause()