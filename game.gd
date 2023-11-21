class_name Game
extends Node2D

const RoundWinner := preload("res://common.gd").RoundWinner

signal game_ended()

## vertical padding. looks better when line doesn't start at the edge
const OFFSET = 4

@export var score: Array[int] = [0, 0]


func _draw():
	var line_x = get_viewport_rect().size.x / 2
	draw_dashed_line(
		Vector2(line_x, OFFSET),
		Vector2(line_x, get_viewport_rect().size.y - OFFSET),
		Color.WHITE,
		2,
		4
	)

func game_over(winner: RoundWinner):
	$Messages/Label.text = "Player %s wins!" % str(winner + 1)
	$Messages/Label.show()
	game_ended.emit()

	# 3 sec timer
	# reset score

	# Paddle: disappear
	# 	- after timer, reappear
	# Ball: keep bouncing around, nothing happens when going off screen
	# 	- after timer, restart at the center with game start timer


func _on_ball_round_won(winner: RoundWinner):
	score[winner] += 1
	$Scores/ScoreLeft.text = str(score[0])
	$Scores/ScoreRight.text = str(score[1])

	if score[winner] == 11:
		game_over(winner)
