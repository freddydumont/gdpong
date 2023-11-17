class_name Player
extends Paddle


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
		Vector2.ZERO + paddle_offset + PADDING_Y, screen_size - paddle_offset - PADDING_Y
	)
