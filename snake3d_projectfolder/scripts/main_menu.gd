extends CenterContainer

onready var game = $"/root/game"
onready var easy_difficulty = $grid/easy_difficulty
onready var medium_difficulty = $grid/medium_difficulty
onready var hard_difficulty = $grid/hard_difficulty
onready var small_size = $grid/small_size
onready var medium_size = $grid/medium_size
onready var large_size = $grid/large_size

func _ready():
	if global.interface_to_display != global.DISPLAY_MAIN_MENU:
		visible = false

func _on_easy_difficulty_pressed():
	game.difficulty = game.DIFFICULTY_EASY
	enable_difficulty_buttons()
	easy_difficulty.disabled = true

func _on_medium_difficulty_pressed():
	game.difficulty = game.DIFFICULTY_MEDIUM
	enable_difficulty_buttons()
	medium_difficulty.disabled = true

func _on_hard_difficulty_pressed():
	game.difficulty = game.DIFFICULTY_HARD
	enable_difficulty_buttons()
	hard_difficulty.disabled = true

func enable_difficulty_buttons():
	easy_difficulty.disabled = false
	medium_difficulty.disabled = false
	hard_difficulty.disabled = false

func _on_small_size_pressed():
	game.size = game.SIZE_SMALL
	enable_size_buttons()
	small_size.disabled = true

func _on_medium_size_pressed():
	game.size = game.SIZE_MEDIUM
	enable_size_buttons()
	medium_size.disabled = true

func _on_large_size_pressed():
	game.size = game.SIZE_LARGE
	enable_size_buttons()
	large_size.disabled = true

func enable_size_buttons():
	small_size.disabled = false
	medium_size.disabled = false
	large_size.disabled = false