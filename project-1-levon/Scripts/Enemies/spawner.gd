extends Node

@export var object_container: Node2D
@export var scene_to_spawn: PackedScene
@export var path_follow: PathFollow2D

func _on_timer_timeout() -> void:
	var instance: Enemy = scene_to_spawn.instantiate()
	object_container.add_child(instance)
	instance.game = self.get_parent().find_child("Entities")
	instance.player = %Player
	
	path_follow.progress_ratio = randf()
	
	var new_position = path_follow.global_position
	instance.global_position = new_position
