class_name Paddle
extends StaticBody2D

@export var speed = 12
@export var is_player: bool = false
@export var padding_x = 16
## Actual size of the paddle drawn
@export var size: Vector2 = Vector2(8, 32)


func _ready():
	var screen_size = get_viewport_rect().size

	# place the paddles on the screen
	if is_player:
		position = Vector2(padding_x, screen_size.y / 2)
	else:
		position = Vector2(screen_size.x - padding_x, screen_size.y / 2)
		# collider isn't the same shape as the paddle, it's just the front
		# it's drawn in the UI for the player, and flipped here for the enemy
		$CollisionShape2D.position = -$CollisionShape2D.position


func _draw():
	# first arg places the origin on the top left corner
	draw_rect(Rect2(-(size / 2), size), Color.WHITE)
