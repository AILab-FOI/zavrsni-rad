extends Area2D

func _on_body_entered(body: Node2D) -> void:
	if body.name == "player":

		body.velocity = Vector2.ZERO
		body.set_physics_process(false)
		body.set_collision_layer(0)
		body.set_collision_mask(0)

		var sprite = body.get_node("AnimatedSprite2D")

		sprite.stop()
		sprite.play("death")
		
		var heart = body.get_node("AnimatedSprite2D3")
		heart.animation = "health"
		heart.frame = 4
		await sprite.animation_finished

		get_tree().reload_current_scene()
