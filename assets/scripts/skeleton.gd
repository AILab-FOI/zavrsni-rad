extends CharacterBody2D

const SPEED = 100.0

var direction = -1.0
var was_ground = true

func _ready():
	$AnimatedSprite2D.flip_h = direction < 0

func _physics_process(delta: float) -> void:
	if not is_on_floor():
		velocity += get_gravity() * delta

	velocity.x = SPEED * direction
	var ground = $RayCast2D.is_colliding()
	
	if was_ground and not ground:
		direction *= -1
		$AnimatedSprite2D.flip_h = direction < 0
	was_ground = ground
	
	move_and_slide()

	if is_on_wall():
		direction = -direction
		$AnimatedSprite2D.flip_h = direction < 0
