extends Control

@onready var label: Label = $Label

var timer = 0.0

func _process(delta):
	timer += delta
	
	var t = int(timer)
	var hours = int(float(t) / 3600)
	var minutes = int(float(t % 3600) / 60)
	var seconds = t % 60
	
	label.text = "%02d:%02d:%02d" % [hours, minutes, seconds]

func get_time():
	return label.text

func get_time_seconds():
	return int(timer)
