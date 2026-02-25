extends CharacterBody2D
class_name Player

@export var SPEED = 300.0
@export var ACCELERATION = 3000.0
@export var DECCELERATION = 1500.0

@onready var player_sprite : AnimatedSprite2D = $PlayerSprite
@onready var weapon_manager : WeaponManager = $WeaponManager

func _physics_process(delta: float) -> void:
	var movement_vector = Input.get_vector("Left", "Right", "Up", "Down").normalized()
	if movement_vector:
		velocity = velocity.move_toward(movement_vector * SPEED, delta * ACCELERATION)
	else:
		velocity = velocity.move_toward(movement_vector * SPEED, delta * DECCELERATION)
	if velocity != Vector2.ZERO:
		player_sprite.play()
	else:
		player_sprite.pause()

	move_and_slide()
