extends Node2D

var points_left : int = 0
var points_right : int = 0
# Called when the node enters the scene tree for the first time.
func _ready():
	GlobalSignals.connect("score_left", score_left)
	GlobalSignals.connect("score_right", score_right)

func score_left():
	points_left = points_left + 1
	$Control/ScoreLeft.text = str(points_left)
func score_right():
	points_right = points_right + 1
	$Control/ScoreRight.text = str(points_right)
