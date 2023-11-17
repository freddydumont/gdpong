class_name Ball
extends CharacterBody2D

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
	# spawn the ball at the center
	position = Vector2(get_viewport_rect().size / 2)
	speed = initial_speed
	velocity = Vector2.ZERO

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
	launch_ball(LaunchSide.RANDOM)


func _physics_process(delta):
	var collision = move_and_collide(velocity * delta)
	if collision:
		velocity = velocity.bounce(collision.get_normal())

		# when ball collides with paddle, increase its speed
		if collision.get_collider() is Paddle:
			speed += speed_increase
			velocity = velocity.normalized() * speed

# TODO: implement scoring system
func _on_visible_on_screen_notifier_2d_screen_exited():
	if position.x < 0:
		# left lost
		launch_ball(LaunchSide.LEFT)
	elif position.x > get_viewport_rect().size.x:
		# right lost
		launch_ball(LaunchSide.RIGHT)
	else:
		printerr("ball exited screen at unexpected position: ", position)
		launch_ball(LaunchSide.RANDOM)
