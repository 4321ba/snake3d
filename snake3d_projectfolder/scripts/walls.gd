extends ImmediateGeometry

onready var game = $"/root/game"

func _ready():
	call_deferred("setup")

func setup():
	begin(Mesh.PRIMITIVE_LINES)
	for main_axis in range(3):
		var length = global.arena_size[main_axis]
		var possible_axes = range(3)
		possible_axes.remove(main_axis)
		for wall_direction in range(2):
			var plane_axis = possible_axes[wall_direction]
			var remaining_axis = possible_axes[1 - wall_direction]
			for line_number in range(global.arena_size[plane_axis] + 1):
				var line_start = Vector3()
				line_start[plane_axis] = line_number
				for wall_position in range(2):
					var remaining_axis_offset = global.arena_size[remaining_axis] * wall_position
					line_start[remaining_axis] = remaining_axis_offset
					var line_end = line_start
					line_end[main_axis] = length
					add_vertex(line_start + game.arena_offset)
					add_vertex(line_end + game.arena_offset)
	end()