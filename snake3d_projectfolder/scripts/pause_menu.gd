extends Control

var animation_time = 0.5
var darkest_alpha = 0.5

var visible_color = null
var regular_color = null

onready var game = $"/root/game"
onready var darkener = $darkener
onready var label = $center/label
onready var pause_button = $margin/separator/pause
onready var restart_button = $margin/separator/restart

func _ready():
	regular_color = darkener.color
	visible_color = Color(regular_color.r, regular_color.g, regular_color.b, darkest_alpha)
	if global.interface_to_display == global.DISPLAY_MAIN_MENU:
		pause_button.hide()
		restart_button.hide()
		darkener.color = visible_color

func _on_quit_pressed():
	game.quit()

func _on_playmenu_pressed():
	game.toggle_play_state()

func _on_restart_pressed():
	game.reload()

func _on_pause_pressed():
	game.toggle_pause()

func animate_darkness(is_fading_in):
	var color_to = regular_color
	if is_fading_in:
		color_to = visible_color
	game.tween.interpolate_property(darkener, "color", darkener.color, color_to, animation_time, Tween.TRANS_SINE, Tween.EASE_IN_OUT)
	game.tween.start()

func set_label_text(text):
	label.text = text