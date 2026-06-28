extends Area2D

@onready var pickup_heart: AudioStreamPlayer = $"../pickup_heart"

func _on_body_entered(body):
	if body.has_method("heal") and body.health < body.max_health:
		body.heal(1)
		pickup_heart.play()
		queue_free()
