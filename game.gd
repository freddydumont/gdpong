extends Node2D

func _draw():
	## vertical padding. looks better when line doesn't start at the edge
	const offset = 4

	var line_x = get_viewport_rect().size.x / 2
	draw_dashed_line(Vector2(line_x, offset), Vector2(line_x, get_viewport_rect().size.y - offset), Color.WHITE, 2, 4)


# Called when the node enters the scene tree for the first time.
func _ready():
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
