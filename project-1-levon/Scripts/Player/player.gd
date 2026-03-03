extends CharacterBody2D
class_name Player

@export var SPEED = 300.0
@export var ACCELERATION = 3000.0
@export var DECCELERATION = 1500.0

@onready var player_sprite : AnimatedSprite2D = $PlayerSprite
@onready var hurtbox: Area2D = $HurtBox

var experience = 0
var level = 0
var is_invulnerable = false
var health = 10

func _ready() -> void:
	$HurtBox.area_entered.connect(_on_area_entered)
func _on_area_entered(area: Node2D) -> void:
	if area is XpOrb:
		experience += 1
		area.collected()
	print(experience)
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
	
func damage(amount):
	health -= amount
	print("Damaged: " + str(amount))


func _on_damage_timer_timeout() -> void:
	if is_invulnerable: return
	
	var areas = hurtbox.get_overlapping_areas()
	for area in areas:
		damage(area.damage)
