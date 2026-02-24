extends Enemy

@onready var walkAnimation = $ZombieSprite 
var player: CharacterBody2D

func _physics_process(delta):
	var target_pos = player.global_position
	var direction = global_position.direction_to(target_pos)
	velocity = direction * movement_speed

	for i in get_slide_collision_count():
		var collision = get_slide_collision(i)
		if collision.get_collider() is CharacterBody2D:
			velocity = Vector2.ZERO
			break

	if velocity != Vector2.ZERO:
		walkAnimation.play()
	else:
		walkAnimation.pause()

	super(delta)  # calls move_and_slide() from enemy.gd
