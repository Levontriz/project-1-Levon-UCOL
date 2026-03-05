extends Enemy

@onready var walkAnimation = $ZombieSprite

const SEPARATION_RADIUS = 80.0**2
const SEPARATION_STRENGTH = 5.0

func _physics_process(delta):
	
	if velocity != Vector2.ZERO:
		walkAnimation.play()
	else:
		walkAnimation.pause()
	
	var target_pos = player.global_position
	var direction = global_position.direction_to(target_pos)
	velocity = direction * movement_speed

	# Separation: push away from nearby zombies so they don't stack
	var separation = Vector2.ZERO
	for body in $Seperation.get_overlapping_bodies():
		if body == self:
			continue
		var diff:Vector2 = global_position - body.global_position
		var dist = diff.length_squared()
		if dist < SEPARATION_RADIUS and dist > 0:
			separation += diff.normalized() * (SEPARATION_RADIUS - dist)

	velocity += separation * SEPARATION_STRENGTH * delta

	super(delta)  # calls move_and_slide() from enemy.gd
