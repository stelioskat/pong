extends Node2D

var points_left : int = 0
var points_right : int = 0
var playing : bool = false

# Called when the node enters the scene tree for the first time.
func _ready():
	GlobalSignals.connect("score_left", score_left)
	GlobalSignals.connect("score_right", score_right)
	game_over("PONG")
	
func _process(delta):
	if Input.is_action_pressed("start"):
		if not playing:
			game_start()
	if Input.is_action_just_pressed("quit"):
		if playing:
			game_over("PONG")
		else:
			get_tree().quit()
	
func game_start():
	playing = true
	$UI/Title.visible = false
	$UI/Subtitle.visible = false
	propagate_call("on_game_start")

func game_over(result):
	playing = false
	$UI/Title.text = result
	$UI/Title.visible = true
	$UI/Subtitle.visible = true
	propagate_call("on_game_over")

func score_left():
	points_left = points_left + 1
	$UI/ScoreLeft.text = str(points_left)
	check_rules()

func score_right():
	points_right = points_right + 1
	$UI/ScoreRight.text = str(points_right)
	check_rules()

func check_rules():
	var lead : int = max(points_left, points_right)
	var diff : int = points_left - points_right
	if lead >= 10:
		if diff > 0:
			game_over("loser")
		elif diff < 0:
			game_over("winner")


