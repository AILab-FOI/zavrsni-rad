extends CharacterBody2D

@onready var player: AnimatedSprite2D = $AnimatedSprite2D
@onready var stamina_bar: AnimatedSprite2D = $AnimatedSprite2D2
@onready var health_bar: AnimatedSprite2D = $AnimatedSprite2D3

const WALK_SPEED = 500.0
const SPRINT_SPEED = 900.0
const JUMP_VELOCITY = -1000.0
const OFFSET_FIX = -15

var max_stamina = 100.0
var stamina = 100.0
var max_health = 4
var health = 3
var drain = 25.0
var regen = 15.0

var exhausted = false
var damage = false
var attacking = false
var dead = false

func _ready():
	update_health_ui()

func _physics_process(delta: float) -> void:
	if dead:
		return

	var current_speed = WALK_SPEED
	var direction := Input.get_axis("left", "right")

	if health > 0:
		for i in range(get_slide_collision_count()):
			var collision = get_slide_collision(i)
			if collision.get_collider().name == "TileMapSpikes":
				if not damage:
					damage = true
					take_damage(4)

	if damage:
		damage = false

	if not attacking and not dead:
		if direction != 0:
			player.play("walk")
		else:
			player.play("idle")

	if not is_on_floor():
		velocity += get_gravity() * delta

	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	if Input.is_action_pressed("sprint") and stamina > 0 and not exhausted and direction != 0 and not is_on_wall() and not attacking:
		current_speed = SPRINT_SPEED
		stamina -= drain * delta
		player.speed_scale = 2.0
	else:
		current_speed = WALK_SPEED
		player.speed_scale = 1.0
	if dead:
		player.speed_scale = 1.0

	if not Input.is_action_pressed("sprint") and stamina < max_stamina:
		stamina += regen * delta

	stamina = clamp(stamina, 0, max_stamina)

	if stamina <= 0:
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

	if not attacking:
		if direction:
			velocity.x = direction * current_speed
		else:
			velocity.x = move_toward(velocity.x, 0, current_speed)
	else:
		velocity.x = 0

	move_and_slide()

	if direction == 1.0:
		player.flip_h = false
		player.offset.x = 0
	elif direction == -1.0:
		player.flip_h = true
		player.offset.x = OFFSET_FIX

	if Input.is_action_just_pressed("attack") and not attacking and is_on_floor():
		attacking = true
		player.play("attack")

func _on_animated_sprite_2d_animation_finished() -> void:
	if player.animation == "attack":
		attacking = false

func update_health_ui():
	health_bar.animation = "health"
	health_bar.frame = max_health - health

func die():
	if dead:
		return
	dead = true
	health = 0
	update_health_ui()

	velocity = Vector2.ZERO
	player.play("death")
	await player.animation_finished
	get_tree().reload_current_scene()

func heal(amount):
	health += amount
	health = clamp(health, 0, max_health)
	update_health_ui()

func take_damage(amount):
	if dead:
		return
	health -= amount
	health = clamp(health, 0, max_health)
	update_health_ui()

	if health <= 0:
		die()
