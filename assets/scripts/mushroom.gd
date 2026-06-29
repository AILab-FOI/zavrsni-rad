extends CharacterBody2D

@onready var hit: AudioStreamPlayer = $"../hit"

const SPEED = 400.0

var direction = -1.0
var health = 4
var was_ground = true
var player = null
var attacking = false
var hurt = false

func take_damage(amount):
	if health <= 0:
		return
	health -= amount
	if health <= 0:
		velocity = Vector2.ZERO
		set_physics_process(false)
		$AnimatedSprite2D.play("death")
		await $AnimatedSprite2D.animation_finished
		queue_free()
	else:
		hurt = true
		hit.play()
		$AnimatedSprite2D.play("hurt")
		await $AnimatedSprite2D.animation_finished
		hurt = false
		$AnimatedSprite2D.play("run")

func _ready():
	update_facing()

func attack():
	attacking = true
	velocity.x = 0
	$AnimatedSprite2D.play("attack")
	await $AnimatedSprite2D.animation_finished
	attacking = false
	$AnimatedSprite2D.play("run")

func _physics_process(delta: float) -> void:
	if not is_on_floor():
		velocity += get_gravity() * delta

	if not attacking and not hurt:
		velocity.x = SPEED * direction
	else:
		velocity.x = 0
	var ground = $RayCast2D.is_colliding()
	
	if was_ground and not ground:
		direction *= -1
		update_facing()
	was_ground = ground
	
	move_and_slide()

	if is_on_wall():
		direction = -direction
		update_facing()
	
	if player and not attacking and not hurt:
		var x = player.global_position.x - global_position.x
		direction = sign(x)
		update_facing()
		attack()

func update_facing():
	$AnimatedSprite2D.flip_h = direction < 0
	if direction > 0:
		$EnemyHitbox/CollisionShape2D.position.x = abs($EnemyHitbox/CollisionShape2D.position.x)
		$RayCast2D.position.x = abs($RayCast2D.position.x)
	else:
		$EnemyHitbox/CollisionShape2D.position.x = -abs($EnemyHitbox/CollisionShape2D.position.x)
		$RayCast2D.position.x = -abs($RayCast2D.position.x)

func _on_animated_sprite_2d_frame_changed() -> void:
	if $AnimatedSprite2D.animation == "attack":
		if $AnimatedSprite2D.frame == 6:
			if player:
				player.take_damage(1)

func _on_enemy_hitbox_body_entered(body: Node2D) -> void:
		if body.is_in_group("player"):
			player = body

func _on_enemy_hitbox_body_exited(body: Node2D) -> void:
		if body.is_in_group("player"):
			player = null
