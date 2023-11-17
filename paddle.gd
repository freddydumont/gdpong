class_name Paddle
extends Area2D

@export var speed = 400
var screen_size
var paddle_offset

## Used with clamp() to prevent paddle from touching the screen edge
const PADDING_Y = Vector2(2, 2)


func _ready():
	screen_size = get_viewport_rect().size
	## used with `clamp()` to prevent the player from going out of bounds
	paddle_offset = $CollisionShape2D.shape.extents

# Gets the collision shape and draw a rectangle of the same dimensions
func _draw():
	var rect = $CollisionShape2D.shape.get_rect()
	draw_rect(rect, Color.WHITE)

