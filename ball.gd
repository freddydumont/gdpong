class_name Ball
extends CharacterBody2D

@export var color = Color.WHITE
@export var speed = 240
@export var speed_increase = 60
## The maximum angle variation from the horizontal axis (in degrees).
## Goes in both y and -y so total sector is var * 2
@export var launch_angle_range = 70


func _draw():
	var radius = $CollisionShape2D.shape.radius
	draw_circle(Vector2.ZERO, radius, color)


## Launches the ball in a random direction when the game starts
func launch_ball():
	# spawn the ball at the center
	position = Vector2(get_viewport_rect().size / 2)
	velocity = Vector2.ZERO

	# Calculate the launch angle, randomly pick between left and right directions
	var launch_angle = randf_range(-launch_angle_range, launch_angle_range)
	launch_angle = deg_to_rad(launch_angle)

	if randf() > 0.5:
		launch_angle += PI  # This will send the ball to the right

	# Set the velocity according to the launch angle and speed
	velocity = Vector2(cos(launch_angle), sin(launch_angle)).normalized() * speed


func _ready():
	launch_ball()


func _physics_process(delta):
	var collision = move_and_collide(velocity * delta)
	if collision:
		velocity = velocity.bounce(collision.get_normal())

		# when ball collides with paddle, increase its speed
		if collision.get_collider() is Paddle:
			speed += speed_increase
			velocity = velocity.normalized() * speed


func _on_VisibilityNotifier2D_screen_exited():
	# Deletes the ball when it exits the screen
	queue_free()
