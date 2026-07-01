extends Node2D

@onready var hover: AudioStreamPlayer = $Control/hover
@onready var intro: AudioStreamPlayer = $intro

func _on_continue_mouse_entered() -> void:
	hover.play()

func _on_continue_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/main.tscn")

func _ready():
	intro.play()

func _process(_delta):
	if not intro.playing:
		intro.play()
