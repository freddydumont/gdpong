class_name Game
extends Node2D

const RoundWinner := preload("res://common.gd").RoundWinner

signal game_ended
signal game_restarted

## vertical padding. looks better when line doesn't start at the edge
@export var dashed_line_padding = 4
@export var score: Array[int] = [0, 0]


func _draw():
	var line_x = get_viewport_rect().size.x / 2
	draw_dashed_line(
		Vector2(line_x, dashed_line_padding),
		Vector2(line_x, get_viewport_rect().size.y - dashed_line_padding),
		Color.WHITE,
		2,
		4
	)


func game_over(winner: RoundWinner):
	# Announce the winner on screen
	$Messages/Label.text = "Player %s wins!" % str(winner + 1)
	$Messages/Label.show()

	# Send game over signal to other classes
	game_ended.emit()

	# Start a 3 sec timer to restart the game
	# Ball will continue bouncing around but paddles will disappear
	($GameRestartTimer as Timer).start()


func update_scores_text():
	$Scores/ScoreLeft.text = str(score[0])
	$Scores/ScoreRight.text = str(score[1])


func _on_ball_round_won(winner: RoundWinner):
	score[winner] += 1
	update_scores_text()

	if score[winner] == 11:
		game_over(winner)


func _on_game_restart_timer_timeout():
	# Reset scores to 0
	score = [0, 0]
	update_scores_text()

	# Hide the game over message
	$Messages/Label.hide()

	# Send signal to other classes that game has restarted
	game_restarted.emit()
