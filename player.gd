extends Area2D

@export var speed = 400
var screen_size
var player_offset

const PADDING_Y = Vector2(2, 2)


func _ready():
	screen_size = get_viewport_rect().size
	## used with `clamp()` to prevent the player from going out of bounds
	player_offset = $CollisionShape2D.shape.extents


func _process(delta):
	var velocity = Vector2.ZERO

	if Input.is_action_pressed("ui_up"):
		velocity.y -= 1
	if Input.is_action_pressed("ui_down"):
		velocity.y += 1

	if velocity.length() > 0:
		velocity = velocity.normalized() * speed

	position += velocity * delta
	position = position.clamp(
		Vector2.ZERO + player_offset + PADDING_Y, screen_size - player_offset - PADDING_Y
	)
