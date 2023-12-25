extends CharacterBody2D

signal destroyed
signal rico

@export var speed : float = 500.0
var left_sfx = load("res://audio/left.wav")
var right_sfx = load("res://audio/right.wav")
var border_sfx = load("res://audio/border.wav")

var direction = Vector2.RIGHT.rotated(PI/8)

func _physics_process(delta):
	velocity = direction * speed

	var collision = move_and_collide(velocity*delta)
	
	if collision:
		var collider = collision.get_collider()
		var normal = collision.get_normal()
		
		if collider.is_in_group("racket"):
			if normal.x == 0:
				return
			elif normal.x > 0:
				$SoundFX.set_stream(left_sfx)
				$SoundFX.play(0.19) 
			else:
				$SoundFX.set_stream(right_sfx)
				$SoundFX.play(0.19) 
			
			var col_y = collider.position.y
			var width = collider.get_node("CollisionShape2D").shape.size.y
			var y_offset = normal.x * (global_position.y-col_y) / width/2
			direction = normal.rotated(3*PI/4*y_offset)
			
		elif collider.is_in_group("border"):
			$SoundFX.set_stream(border_sfx)
			$SoundFX.play() 
			var ricocet_angle = -(normal.angle_to(direction)-PI/2)
			direction = direction.bounce(normal)
		GlobalSignals.ball_hit.emit(direction, speed)
 
func set_direction(dir:Vector2):
	direction = dir
	
func destroy():
	destroyed.emit()
	queue_free()
