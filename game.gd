extends Node2D


func _draw():
	## vertical padding. looks better when line doesn't start at the edge
	const OFFSET = 4

	var line_x = get_viewport_rect().size.x / 2
	draw_dashed_line(
		Vector2(line_x, OFFSET),
		Vector2(line_x, get_viewport_rect().size.y - OFFSET),
		Color.WHITE,
		2,
		4
	)
