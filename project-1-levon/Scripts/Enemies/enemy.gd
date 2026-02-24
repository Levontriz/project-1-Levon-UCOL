extends CharacterBody2D
class_name Enemy

@export var max_health: int = 10
@export var movement_speed: float = 50.0

var current_health: int
var enemy_velocity: Vector2 = Vector2.ZERO

func _ready():
	current_health = max_health

func take_damage(amount: int):
	current_health -= amount
	if current_health <= 0:
		die()

func die():
	queue_free()

func _process(delta):
	# Base enemies might not have movement here, but specific enemies will override/add to this
	pass

# In enemy.gd, replace _physics_process with:
func _physics_process(delta):
	var collision = move_and_collide(velocity * delta)
	if collision:
		# Don't slide along the player — just stop
		if collision.get_collider() is CharacterBody2D:
			velocity = Vector2.ZERO
