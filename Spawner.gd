extends Marker2D

var ball_scene = preload("res://scenes/ball.tscn")
var active = true

func start():
	active = true
	spawn()
	
func stop():
	active = false

func spawn():
	if not active:
		return
		
	var ball = ball_scene.instantiate() as CharacterBody2D
	
	# Randomize spawning position and direction
	ball.set_global_position(Vector2(0,randi_range(-200,200)))
	var direction = (1 if randf() > 0.5 else -1) * Vector2.RIGHT.rotated(randf_range(0, PI/4))
	ball.set_direction(direction)
	
	ball.connect("destroyed", spawn)
	call_deferred("add_child", ball)

func on_game_start():
	start()

func on_game_over():
	stop()
	#propagate_call("queue_free")
