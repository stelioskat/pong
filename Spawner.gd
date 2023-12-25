extends Marker2D

var ball_scene = preload("res://scenes/ball.tscn")

# Called when the node enters the scene tree for the first time.
func _ready():
	spawn()

func spawn():
	var ball = ball_scene.instantiate() as CharacterBody2D
	
	# Randomize spawning position and direction
	ball.set_global_position(Vector2(0,randi_range(-200,200)))
	var direction = (1 if randf() > 0.5 else -1) * Vector2.RIGHT.rotated(randf_range(0, PI/4))
	ball.set_direction(direction)
	
	ball.connect("destroyed", spawn)
	call_deferred("add_child", ball)
