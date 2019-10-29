extends Node2D

onready var game = $"/root/game"

func _ready():
	if global.interface_to_display == global.DISPLAY_MAIN_MENU:
		visible = false

func _on_up_pressed():
	game.snake.turn(Vector3.RIGHT)

func _on_down_pressed():
	game.snake.turn(Vector3.LEFT)

func _on_left_pressed():
	game.snake.turn(Vector3.UP)

func _on_right_pressed():
	game.snake.turn(Vector3.DOWN)

func _notification(what):
	if what == MainLoop.NOTIFICATION_WM_GO_BACK_REQUEST:
		game.toggle_pause()