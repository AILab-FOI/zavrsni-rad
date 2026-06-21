extends CharacterBody2D
@onready var player: AnimatedSprite2D = $AnimatedSprite2D
@onready var stamina_bar: AnimatedSprite2D = $AnimatedSprite2D2

const WALK_SPEED = 500.0
const SPRINT_SPEED = 900.0
const JUMP_VELOCITY = -1000.0
var max_stamina = 100.0
var stamina = 100.0
var drain = 25.0
var regen = 15.0
var exhausted = false
var damage = false

func _physics_process(delta: float) -> void:
	
	var current_speed = WALK_SPEED
	
	for i in get_slide_collision_count():
		var collision = get_slide_collision(i)
		
		if collision.get_collider().name == "TileMapSpikes":
			if damage == false:
				damage = true
				
				velocity = Vector2.ZERO
				set_physics_process(false)
				set_collision_layer(0)
				set_collision_mask(0)
				
				player.speed_scale = 1.0
				player.stop()
				
				var sprite = get_node("AnimatedSprite2D")
				
				sprite.stop()
				sprite.play("death")
				
				var heart = get_node("AnimatedSprite2D3")
				heart.animation = "health"
				heart.frame = 4
				await sprite.animation_finished
				
				get_tree().call_deferred("reload_current_scene")
	
	if velocity.x > 1 or velocity.x < -1:
		player.animation = "walk"
	else:
		player.animation = "idle"
	
	if not is_on_floor():
		velocity += get_gravity() * delta

	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	var direction := Input.get_axis("left", "right")
	
	if Input.is_action_pressed("sprint") and stamina > 0 and not exhausted and direction != 0 and not is_on_wall():
		current_speed = SPRINT_SPEED
		stamina = stamina - (drain * delta)
		player.speed_scale = 2.0
	else:
		current_speed = WALK_SPEED
		player.speed_scale = 1.0
	
	if not Input.is_action_pressed("sprint") and stamina < max_stamina:
		stamina += regen * delta
	
	stamina = clamp(stamina, 0, max_stamina)
	if stamina <= 0:
		stamina = 0
		exhausted = true
	elif stamina > 5:
		exhausted = false
	
	stamina_bar.animation = "stamina"
	if stamina > 75:
		stamina_bar.frame = 0
	elif stamina > 50:
		stamina_bar.frame = 1
	elif stamina > 25:
		stamina_bar.frame = 2
	elif stamina > 5:
		stamina_bar.frame = 3
	else:
		stamina_bar.frame = 4
	
	if direction:
		velocity.x = direction * current_speed
	else:
		velocity.x = move_toward(velocity.x, 0, current_speed)
	
	move_and_slide()
	
	if direction == 1.0:
		$AnimatedSprite2D.flip_h = false
		$CollisionShape2D.disabled = true
		$CollisionShape2D2.disabled = false
	elif direction == -1.0:
		$AnimatedSprite2D.flip_h = true
		$CollisionShape2D.disabled = false
		$CollisionShape2D2.disabled = true
