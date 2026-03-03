extends CharacterBody2D
class_name Enemy

@export var max_health: int = 10
@export var movement_speed: float = 50.0
@export var xp_orb: PackedScene
@export var game: Node2D

var current_health: int
var enemy_velocity: Vector2 = Vector2.ZERO

func _ready():
	current_health = max_health

func take_damage(amount: int):
	current_health -= amount
	if current_health <= 0:
		die()

func die(): 
	var xp_orb_instance: Node2D = xp_orb.instantiate()
	xp_orb_instance.position = global_position
	game.call_deferred("add_child", xp_orb_instance)
	call_deferred("queue_free")

func _process(delta):
	# Base enemies might not have movement here, but specific enemies will override/add to this
	pass

func _physics_process(delta):
	move_and_slide()
