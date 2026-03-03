extends Node2D

@onready var hitbox = $Hitbox

func _on_damage_timer_timeout() -> void:
	var hurtboxes = hitbox.get_overlapping_areas()
	for area in hurtboxes:
		if area.has_method("take_damage"):
			area.take_damage(hitbox.damage)
