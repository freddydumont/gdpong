class_name Game
extends Node2D

const RoundWinner := preload("res://common.gd").RoundWinner

## vertical padding. looks better when line doesn't start at the edge
const OFFSET = 4

var score: Array[int] = [0, 0]


func _draw():
	var line_x = get_viewport_rect().size.x / 2
	draw_dashed_line(
		Vector2(line_x, OFFSET),
		Vector2(line_x, get_viewport_rect().size.y - OFFSET),
		Color.WHITE,
		2,
		4
	)


func _on_ball_round_won(winner: RoundWinner):
	score[winner] += 1
