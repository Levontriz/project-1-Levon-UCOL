extends Node2D

@export var PlayerScene : PackedScene
@export var TestEnemy : PackedScene
var weapon : PackedScene = preload("res://Scenes/Weapons/sword.tscn")

"""
Instances the player and places them in the world
"""
func _ready() -> void:
	print()
	var player_instance : Player = PlayerScene.instantiate()
	player_instance.z_index = 1
	add_child(player_instance)
	player_instance.weapon_manager.weapon = weapon
	
	var enemy_instance : CharacterBody2D = TestEnemy.instantiate()
	enemy_instance.z_index = 0
	add_child(enemy_instance)
	enemy_instance.player = player_instance
