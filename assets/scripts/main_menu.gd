extends Node2D

@onready var hover: AudioStreamPlayer = $Control/hover

func _on_start_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/story.tscn")

func _on_quit_pressed() -> void:
	get_tree().quit()

func _on_start_mouse_entered() -> void:
	hover.play()

func _on_quit_mouse_entered() -> void:
	hover.play()
