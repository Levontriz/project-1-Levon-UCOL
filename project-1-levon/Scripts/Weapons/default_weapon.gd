extends Node2D
class_name DefaultPrimaryWeapon

@export var weapon_texture : Sprite2D
@export var weapon_rotation_weight : float = 15
@export var damage: int = 10


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

func look_at_mouse(delta: float) -> void:
	# Get all sprites
	var direction = get_global_mouse_position() - global_position
	var target_angle = direction.angle()
	rotation = lerp_angle(rotation, target_angle, weapon_rotation_weight * delta)
	
	var weapon_rotation = wrapf(global_rotation_degrees, -180, 180)

	var children = get_children()

	# Check if the angle falls in the "Right" hemisphere (-90 to 90)
	if weapon_rotation > -90 and weapon_rotation < 90:
		for child in children:
			if child.get_class() == "Sprite2D" or child.get_class() == "AnimatedSprite2D":
				child.flip_v = false
	else:
		for child in children:
			if child.get_class() == "Sprite2D" or child.get_class() == "AnimatedSprite2D":
				child.flip_v = true
