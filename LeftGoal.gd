extends Area2D

func _on_body_entered(body):
	if body.is_in_group("ball"):
		GlobalSignals.score_right.emit()
		body.destroy()
