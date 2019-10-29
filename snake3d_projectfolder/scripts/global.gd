extends Node

enum {DISPLAY_MAIN_MENU, DISPLAY_GAMEPLAY}
var interface_to_display = DISPLAY_MAIN_MENU

var sizes = [Vector3(7, 5, 10), Vector3(21, 10, 16), Vector3(31, 20, 40)]
var arena_size = sizes[1]
var rock_multipliers = [0.2, 0.3, 0.4]

var rock_count = 20
var orange_count = 3