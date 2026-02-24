extends CharacterBody2D


@export var SPEED = 300.0
@export var ACCELERATION = 3000.0
@export var DECCELERATION = 1000.0

@onready var player_sprite = $PlayerSprite
@onready var weapon = $Weapon

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
	var direction = get_global_mouse_position() - weapon.global_position
	var target_angle = direction.angle()
	weapon.rotation = lerp_angle(weapon.rotation, target_angle, 15.0 * delta)

	move_and_slide()
