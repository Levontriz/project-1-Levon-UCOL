extends Node2D
class_name XpOrb

var player : Player
@onready var timer = $Timer

var animate = 0

func collected():
	var fly_direction = randf_range(0, 2) 
	var fly_direction_rad = fly_direction * PI
	
	rotation = fly_direction_rad
	animate = 1

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if animate == 1:
		if timer.is_stopped():
			timer.start()
		position += lerp(position, transform.x, .75) * delta
		# position += transform.x * 500 * delta
	elif animate == 2:
		global_position = global_position.lerp(player.global_position, .1) * delta


func _on_timer_timeout() -> void:
	animate = 2
