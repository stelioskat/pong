extends CharacterBody2D

@export var speed: float = 550

func on_game_start():
	global_position = Vector2(760, 256)
	visible = true

func on_game_over():
	visible = false

func _physics_process(delta):
	if Input.is_action_pressed("up"):
		velocity.y = -speed
	elif Input.is_action_pressed("down"):
		velocity.y = speed
	else:
		velocity.y = 0	

	move_and_collide(velocity * delta)

