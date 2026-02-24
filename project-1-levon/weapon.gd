extends Node2D

@export var weapon : Sprite2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	var weapon_rotation = wrapf(weapon.global_rotation_degrees, -180, 180)

	# Check if the angle falls in the "Right" hemisphere (-90 to 90)
	if weapon_rotation > -90 and weapon_rotation < 90:
		weapon.flip_v = false
	else:
		weapon.flip_v = true
		
