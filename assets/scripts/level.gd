extends Node2D

func _on_exit_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		get_tree().call_deferred("change_scene_to_file", "res://scenes/exit.tscn")
