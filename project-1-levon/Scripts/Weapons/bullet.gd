extends Node2D

@export var damage = 4

func _physics_process(delta: float) -> void:
	position += transform.x * 500 * delta


func _on_area_entered(area: Area2D) -> void:
	if area.has_method("take_damage"):
		area.take_damage(damage)
		queue_free()
