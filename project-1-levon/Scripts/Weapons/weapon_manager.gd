extends Node2D
class_name WeaponManager

var weapon : PackedScene = PackedScene.new()
var weapon_instance : DefaultPrimaryWeapon
@onready var PrimaryWeapon : Node = $PrimaryWeapon

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass
	
func _process(delta: float) -> void:
	if is_node_ready() && !weapon_instance:
		weapon_instance = weapon.instantiate()
		PrimaryWeapon.add_child(weapon_instance)
	
	if Input.is_action_pressed("fire"):
		weapon_instance.fire()
		
	weapon_instance.look_at_mouse(delta)
