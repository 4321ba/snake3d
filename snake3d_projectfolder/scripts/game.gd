extends Node

var dying_time = 3
var default_refresh_time = 0.4

var score = 0
var game_over = false

enum {DIFFICULTY_EASY, DIFFICULTY_MEDIUM, DIFFICULTY_HARD}
var difficulty
enum {SIZE_SMALL, SIZE_MEDIUM, SIZE_LARGE}
var size

var arena_offset = - Vector3(int(global.arena_size.x / 2), int(global.arena_size.y / 2), global.arena_size.z - 1)
var arena_aabb = AABB(arena_offset, global.arena_size - Vector3.ONE)

onready var tween = $tween
onready var dead_timer = $dead_timer
onready var camera = $world/camera_pivot
onready var gridmap = $world/gridmap
onready var rocks_and_oranges = $world/rocks_and_oranges
onready var snake = $world/snake
onready var update_timer = $world/snake/update_timer
onready var pause_menu = $interface/pause_menu

func level_up():
	snake.length += snake.length_increase
	camera.current_refresh_multiplier *= camera.refresh_multiplier
	score += 1

func reload():
	get_tree().set_pause(false)
	if game_over:
		get_tree().reload_current_scene()
	game_over = true
	pause_menu.animate_darkness(true)
	update_timer.stop()
	dead_timer.start(dying_time)
	camera.smoothly_move(camera.beginning, dying_time)
	pause_menu.set_label_text("Game Over! Your score was {0}.".format([score]))

func toggle_pause():
	if game_over:
		return
	if get_tree().is_paused():
		get_tree().set_pause(false)
		pause_menu.animate_darkness(false)
	else:
		get_tree().set_pause(true)
		pause_menu.animate_darkness(true)

func toggle_play_state():
	if global.interface_to_display == global.DISPLAY_MAIN_MENU:
		global.interface_to_display = global.DISPLAY_GAMEPLAY
		if size != null:
			global.arena_size = global.sizes[size]
		if difficulty != null:
			global.rock_count = int(global.rock_multipliers[difficulty] * pow(global.arena_size.x * global.arena_size.y * global.arena_size.z, float(2) / 3)) - 7
	elif global.interface_to_display == global.DISPLAY_GAMEPLAY:
		global.interface_to_display = global.DISPLAY_MAIN_MENU
	get_tree().reload_current_scene()

func quit():
	get_tree().quit()

func _on_dead_timer_timeout():
	pass