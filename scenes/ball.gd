extends CharacterBody2D

signal destroyed
signal rico

@export var max_speed : float = 650.0
@export var min_speed : float = 450.0

var speed : float = min_speed
var left_sfx = load("res://audio/left.wav")
var right_sfx = load("res://audio/right.wav")
var border_sfx = load("res://audio/border.wav")

var direction : Vector2

func _ready():
	velocity = direction * speed
	GlobalSignals.ball_hit.emit(self)

func _physics_process(delta):
	var collision = move_and_collide(velocity*delta)
	
	if collision:
		speed = min(max_speed, speed + 50)
		var collider = collision.get_collider()
		var normal = collision.get_normal()
		
		if collider.is_in_group("racket"):
			if direction.x < 0:
				$SoundFX.set_stream(left_sfx)
				$SoundFX.play(0.19) 
			else:
				$SoundFX.set_stream(right_sfx)
				$SoundFX.play(0.19) 
			
			var width = collider.get_node("CollisionShape2D").shape.size.y
			var rel_point_on_racket = (global_position.y - collider.position.y) / width/2
			if normal.x != 0:
				direction = normal.rotated(sign(normal.x) * 3*PI/4 * rel_point_on_racket)
			else:
				direction = Vector2(-sign(direction.x),sign(normal.y))
			
		elif collider.is_in_group("border"):
			$SoundFX.set_stream(border_sfx)
			$SoundFX.play() 
			direction = direction.bounce(normal)
	
		velocity = direction * speed
		GlobalSignals.ball_hit.emit(self)
			
 
func set_direction(dir:Vector2):
	direction = dir
	
func destroy():
	destroyed.emit()
	queue_free()

func on_game_over():
	queue_free()
