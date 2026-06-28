extends CanvasLayer

@onready var hover: AudioStreamPlayer = $hover

func _ready() -> void:
	visible = false
	get_tree().paused = false

func _input(_event: InputEvent) -> void:
	if Input.is_action_just_pressed("pause"):
		if get_tree().paused:
			visible = false
			get_tree().paused = false
		else:
			visible = true
			get_tree().paused = true

func _on_continue_pressed() -> void:
	get_tree().paused = false
	hide()

func _on_menu_pressed() -> void:
	get_tree().paused = false
	get_tree().change_scene_to_file("res://scenes/mainmenu.tscn")

func _on_quit_pressed() -> void:
	get_tree().quit()

func _on_continue_mouse_entered() -> void:
	hover.play()

func _on_menu_mouse_entered() -> void:
	hover.play()

func _on_quit_mouse_entered() -> void:
	hover.play()
