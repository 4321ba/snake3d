extends Node

var gridmap = null
onready var game = $"/root/game"

func _ready():
	call_deferred("setup")

func setup():
	gridmap = game.gridmap
	setup_objects(gridmap.BLOCK_ROCK, global.rock_count)
	setup_objects(gridmap.BLOCK_ORANGE, global.orange_count)

func setup_objects(object_id, object_count):
	for index in range(object_count):
		place_object(object_id)

func place_object(object_id):
	for failed_to_place in range(10):
		var possible_location = Vector3(randf(), randf(), randf()) * global.arena_size + game.arena_offset
		if gridmap.get_cell_item(possible_location.x, possible_location.y, possible_location.z) == gridmap.BLOCK_NONE:
			gridmap.set_cell_item(possible_location.x, possible_location.y, possible_location.z, object_id)
			return
		print("Placing object didn't succeed, trying again...")
	print("Placing object failed.")
