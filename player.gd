class_name Player
extends Paddle

var acceleration = 16  # The rate of acceleration
var velocity = Vector2.ZERO


func _physics_process(delta):
	var target_velocity = Vector2.ZERO

	if Input.is_action_pressed("ui_up"):
		target_velocity.y = -speed
	if Input.is_action_pressed("ui_down"):
		target_velocity.y = speed

	# Using lerp to create a smooth transition from current velocity to target velocity,
	# which gives the feeling of acceleration/friction
	velocity.y = lerp(velocity.y, target_velocity.y, acceleration * delta)

	move_and_collide(velocity)
