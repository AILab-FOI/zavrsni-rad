extends Node2D

@onready var main_theme: AudioStreamPlayer = $main_theme

func _ready():
	main_theme.play()

func _on_exit_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		var timer = $player/Control
		Gamedata.final_time = timer.get_time()
		Gamedata.final_time_seconds = timer.get_time_seconds()
		
		if Gamedata.best_time_seconds == -1 or Gamedata.final_time_seconds < Gamedata.best_time_seconds:
			Gamedata.best_time_seconds = Gamedata.final_time_seconds
			Gamedata.best_time = Gamedata.final_time
		get_tree().call_deferred("change_scene_to_file", "res://scenes/exit.tscn")

func _process(_delta):
	if not main_theme.playing:
		main_theme.play()
