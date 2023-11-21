class_name Paddle
extends StaticBody2D

@export var is_left := false

@export_group("Movement")
@export var speed := 12
@export var acceleration := 16
var velocity := Vector2.ZERO

@export_group("Controls")
@export var up_key := ""
@export var down_key := ""

@export_group("Shape")
@export var padding_x := 16
## Actual size of the paddle drawn
@export var size: Vector2 = Vector2(8, 32)


func initialize():
	# reset visibility and collisions
	self.show()
	self.collision_layer = 1

	# place the paddles on the screen
	var screen_size := get_viewport_rect().size

	if is_left:
		position = Vector2(padding_x, screen_size.y / 2)
	else:
		position = Vector2(screen_size.x - padding_x, screen_size.y / 2)
		# collider isn't the same shape as the paddle, it's just the front
		# it's drawn in the UI for the player, and flipped here for the enemy
		$CollisionShape2D.position = -$CollisionShape2D.position


func _ready():
	# connect to the game ended signal
	(get_parent() as Game).game_ended.connect(_on_game_game_ended)

	initialize()


func _draw():
	# first arg places the origin on the top left corner
	draw_rect(Rect2(-(size / 2), size), Color.WHITE)


func _physics_process(delta):
	var target_velocity := Vector2.ZERO

	if Input.is_action_pressed(up_key):
		target_velocity.y = -speed
	if Input.is_action_pressed(down_key):
		target_velocity.y = speed

	# Using lerp to create a smooth transition from current velocity to target velocity,
	# which gives the feeling of acceleration/friction
	velocity.y = lerp(velocity.y, target_velocity.y, acceleration * delta)

	move_and_collide(velocity)


func _on_game_game_ended():
	self.hide()
	self.collision_layer = 2
