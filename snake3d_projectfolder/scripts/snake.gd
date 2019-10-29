extends Node

var length = 10
var length_increase = 3
var color_distance = 3

var snake_coordinates = PoolVector3Array([Vector3(0, 0, 0)])
var basis = Basis(Vector3.FORWARD, 0)

var gridmap = null
onready var game = $"/root/game"

func _ready():
	if global.interface_to_display == global.DISPLAY_GAMEPLAY:
		call_deferred("setup")

func setup():
	gridmap = game.gridmap
	gridmap.set_cell_item(snake_coordinates[0].x, snake_coordinates[0].y, snake_coordinates[0].z, gridmap.BLOCK_HEAD)
	game.update_timer.start(game.default_refresh_time)

func turn(relative_direction):
	var absolute_direction = basis.xform(relative_direction)
	basis = basis.rotated(absolute_direction, PI / 2)
	basis = Basis(basis.x.round(), basis.y.round(), basis.z.round())

func _on_update_timer_timeout():
	var new_head = snake_coordinates[-1] - basis.z
	test_orange(new_head)
	remove_last_block()
	if collides(new_head):
		game.reload()
		return
	place_new_head(new_head)
	apply_secondary_colors()
	game.camera.backward_vector = basis.z
	game.camera.new_transform = Transform(basis, new_head + basis.z + Vector3.ONE / 2)

func test_orange(new_head):
	if gridmap.get_cell_item(new_head.x, new_head.y, new_head.z) != gridmap.BLOCK_ORANGE:
		return
	game.level_up()
	game.rocks_and_oranges.place_object(gridmap.BLOCK_ORANGE)
	gridmap.set_cell_item(new_head.x, new_head.y, new_head.z, gridmap.BLOCK_NONE)

func remove_last_block():
	if snake_coordinates.size() < length:
		return
	gridmap.set_cell_item(snake_coordinates[0].x, snake_coordinates[0].y, snake_coordinates[0].z, gridmap.BLOCK_NONE)
	snake_coordinates.remove(0)

func collides(new_head):
	var collides_with_block = gridmap.get_cell_item(new_head.x, new_head.y, new_head.z) != gridmap.BLOCK_NONE 
	var collides_with_wall = not game.arena_aabb.has_point(new_head)
	return collides_with_block or collides_with_wall

func place_new_head(new_head):
	snake_coordinates.append(new_head)
	gridmap.set_cell_item(snake_coordinates[-2].x, snake_coordinates[-2].y, snake_coordinates[-2].z, gridmap.BLOCK_PRIMARY_SNAKE)
	gridmap.set_cell_item(new_head.x, new_head.y, new_head.z, gridmap.BLOCK_HEAD)

func apply_secondary_colors():
	var current_length = snake_coordinates.size()
	for index in range(color_distance, current_length, color_distance):
		var different_part = snake_coordinates[current_length - 1 - index]
		gridmap.set_cell_item(different_part.x, different_part.y, different_part.z, gridmap.BLOCK_SECONDARY_SNAKE)
		if current_length - 2 < index:
			continue
		var previous_part = snake_coordinates[current_length - 2 - index]
		gridmap.set_cell_item(previous_part.x, previous_part.y, previous_part.z, gridmap.BLOCK_PRIMARY_SNAKE)