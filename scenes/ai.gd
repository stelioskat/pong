extends CharacterBody2D

@export var speed: float = 300
@onready var target : Vector2 = Vector2(0, get_window().size.y/2)

func on_game_start():
	global_position = Vector2(8, 256)
	visible = true

func on_game_over():
	visible = false

func _ready():
	GlobalSignals.connect("ball_hit", update_target)

func _physics_process(delta):
	var diff = target.y - round(global_position.y)
	if abs(diff) > 5 :
		velocity = Vector2(0, sign(diff)) * speed
	else:
		velocity = Vector2.ZERO
	
	move_and_collide(velocity * delta)

func update_target(ball : CharacterBody2D):
	var dir = ball.velocity.normalized()
	var b = dir.y/dir.x * ball.global_position.x - ball.global_position.y
	target = Vector2(0, round(-b) + randi_range(-40, 40))
