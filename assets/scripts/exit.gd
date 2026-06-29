extends Node2D

@onready var hover: AudioStreamPlayer = $Control/hover
@onready var time: Label = $Control/Label2
@onready var best_time: Label = $Control/Label3

func _ready():
	time.text = "Ukupno vrijeme: " + Gamedata.final_time
	best_time.text = "Najbolje vrijeme: " + Gamedata.best_time

func _on_menu_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/mainmenu.tscn")

func _on_quit_pressed() -> void:
	get_tree().quit()

func _on_menu_mouse_entered() -> void:
	hover.play()

func _on_quit_mouse_entered() -> void:
	hover.play()
