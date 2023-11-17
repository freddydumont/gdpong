extends Area2D

var radius
var color = Color(1, 1, 1, 1)


func _ready():
	## spawn the ball at the center for now
	position = Vector2(get_viewport_rect().size / 2)


func _draw():
	radius = $CollisionShape2D.shape.radius
	draw_circle(Vector2.ZERO, radius, color)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
