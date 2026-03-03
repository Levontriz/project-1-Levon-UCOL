extends Button


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	button_down.connect(start)

func start() -> void:
	# This code should be inside an autoload.
	get_tree().change_scene_to_file("res://Scenes/Maps/Game.tscn")
