extends CharacterBody2D

const SPEED = 200.0
const RANGE = 4000.0
var start_p: Vector2
var target: Vector2

func _ready():
	start_p = global_position
	target = start_p + Vector2(RANGE, 0)
	update_facing()

func _physics_process(_delta):
	var dir = (target - global_position).normalized()
	velocity = dir * SPEED
	
	move_and_slide()
	
	if global_position.distance_to(target) < 5:
		if target == start_p:
			target = start_p + Vector2(RANGE, 0)
		else:
			target = start_p
	
	update_facing()

func update_facing():
	$AnimatedSprite2D.flip_h = velocity.x < 0
