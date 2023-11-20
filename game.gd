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
	$Scores/ScoreLeft.text = str(score[0])
	$Scores/ScoreRight.text = str(score[1])

	# TODO: implement game win when a player reaches 11
	#		* Pause the game
	#		* Display a message eg. P1 wins or P2 wins
	#		* Reset the game
	if score[winner] == 11:
		$Messages/Label.text = "Player %s wins!" % str(winner + 1)
		$Messages/Label.show()
