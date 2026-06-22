extends Area2D

func _on_body_entered(body):
	if body.has_method("heal") and body.health < body.max_health:
		body.heal(1)
		queue_free()
