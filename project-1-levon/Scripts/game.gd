extends Node2D

@export var PlayerScene : PackedScene
@export var TestEnemy : PackedScene
"""
Instances the player and places them in the world
"""
func _ready() -> void:
	var player_instance = PlayerScene.instantiate()
	add_child(player_instance)
	var enemy_instance = TestEnemy.instantiate()
	add_child(enemy_instance)
	enemy_instance.player = player_instance

func _process(delta: float) -> void:
	pass
