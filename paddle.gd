class_name Paddle
extends StaticBody2D

@export var speed = 400
@export var is_player: bool = false
@export var padding_x = 16

var screen_size
var paddle_offset

## Used with clamp() to prevent paddle from touching the screen edge
const PADDING_Y = Vector2(2, 2)


func _ready():
	screen_size = get_viewport_rect().size

	## used with `clamp()` to prevent the player from going out of bounds
	paddle_offset = $CollisionShape2D.shape.extents

	# place the paddles on the screen
	if is_player:
		position = Vector2(padding_x, screen_size.y / 2)
	else:
		position = Vector2(screen_size.x - padding_x, screen_size.y / 2)


# Gets the collision shape and draw a rectangle of the same dimensions
func _draw():
	var rect = $CollisionShape2D.shape.get_rect()
	draw_rect(rect, Color.WHITE)
