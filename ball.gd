class_name Ball
extends CharacterBody2D

const RoundWinner = preload("res://common.gd").RoundWinner

signal round_won(winner: RoundWinner)

@export var color = Color.WHITE
@export var initial_speed = 240
@export var speed_increase = 60
## The maximum angle variation from the horizontal axis (in degrees).
## Goes in both y and -y so total sector is var * 2
@export var launch_angle_range = 60

var speed = initial_speed

enum LaunchSide {
	LEFT,
	RIGHT,
	RANDOM,
}


func _draw():
	var radius = $CollisionShape2D.shape.radius
	draw_circle(Vector2.ZERO, radius, color)


## Launches the ball in a random direction when the game starts.
## On reset, launches in the direction of the loser
func launch_ball(side: Ball.LaunchSide):
	var viewport_size = get_viewport_rect().size
	var screen_offset = get_parent().OFFSET

	speed = initial_speed
	velocity = Vector2.ZERO

	# If first ball of the game, start the ball at the center
	# Otherwise, random position along the center line
	if side == LaunchSide.RANDOM:
		position = Vector2(viewport_size / 2)
	else:
		position = Vector2(
			viewport_size.x / 2, randf_range(screen_offset, viewport_size.y - screen_offset)
		)

	# Calculate the launch angle
	var launch_angle = randf_range(-launch_angle_range, launch_angle_range)
	launch_angle = deg_to_rad(launch_angle)

	# check which direction to launch
	if side == LaunchSide.LEFT:
		launch_angle += PI
	elif side == LaunchSide.RANDOM and randf() > 0.5:
		launch_angle += PI

	# Set the velocity according to the launch angle and speed
	velocity = Vector2(cos(launch_angle), sin(launch_angle)).normalized() * speed


func _ready():
	position = Vector2(get_viewport_rect().size / 2)


func _on_timer_timeout():
	launch_ball(LaunchSide.RANDOM)


func _physics_process(delta):
	var collision = move_and_collide(velocity * delta)
	if collision:
		velocity = velocity.bounce(collision.get_normal())

		# TODO: update paddle collision logic so that the bounce
		# 			depends on where it hits on the paddle
		if collision.get_collider() is Paddle:
			# when ball collides with paddle, increase its speed
			speed += speed_increase

			velocity = velocity.normalized()

			# Limit the angle of the bounce to a certain range so it doesn't go straight up
			if abs(velocity.x) < 0.75:
				velocity.x = 0.75 if velocity.x > 0 else -0.75
				velocity.y = sign(velocity.y) * sqrt(1 - velocity.x ** 2)

			velocity = velocity * speed


func _on_visible_on_screen_notifier_2d_screen_exited():
	if position.x < 0:
		round_won.emit(RoundWinner.RIGHT)
		launch_ball(LaunchSide.LEFT)
	elif position.x > get_viewport_rect().size.x:
		round_won.emit(RoundWinner.LEFT)
		launch_ball(LaunchSide.RIGHT)
	else:
		printerr("ball exited screen at unexpected position: ", position)
		launch_ball(LaunchSide.RANDOM)
