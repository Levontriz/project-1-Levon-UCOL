extends Node2D

@onready var firerate_timer = $FireRate
@onready var bullet_scene: PackedScene = preload("res://Scenes/Weapons/bullet.tscn")

var enemies : Array

func fire():
	if enemies.size() <= 0: return
	
	var closest_enemy : Node2D
	var distance = INF
	
	for enemy in enemies:
		var en_dist = global_position.distance_to(enemy.global_position)
		if en_dist < distance:
			closest_enemy = enemy
			distance = en_dist
	var proj_instance = bullet_scene.instantiate()
	var game_node = get_node("/root/Game")
	game_node.add_child(proj_instance)
	proj_instance.global_position = global_position
	proj_instance.rotation = global_position.angle_to_point(closest_enemy.global_position)

func _on_fire_rate_timeout() -> void:
	fire()


func _on_detection_area_body_entered(body: Node2D) -> void:
	if not enemies.has(body):
		enemies.append(body)


func _on_detection_area_body_exited(body: Node2D) -> void:
	if enemies.has(body):
		enemies.erase(body)
