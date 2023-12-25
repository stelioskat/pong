extends CharacterBody2D

@export var speed: float = 300

func _physics_process(delta):
	if Input.is_action_pressed("up"):
		velocity.y = -speed
	elif Input.is_action_pressed("down"):
		velocity.y = speed
	else:
		velocity.y = 0	

	move_and_collide(velocity * delta)
