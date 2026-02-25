extends DefaultPrimaryWeapon
class_name sword

var elapsedIn = 0.0
var elapsedOut = 0.0

var swinging = false

var trail_lifetime = 0.15
var trail_points : Array = []

@onready var trail : Line2D = %Trail

func _ready() -> void:
	%Area2D.body_entered.connect(_on_body_entered)

func _on_body_entered(body: Node2D) -> void:
	if swinging and body is Enemy:
		body.take_damage(damage)

func _process(_delta: float) -> void:
	if swinging:
		var tip_pos = trail.to_local(%Tip.global_position)
		trail_points.append([tip_pos, Time.get_ticks_msec() / 1000.0])
	
	var now = Time.get_ticks_msec() / 1000.0
	trail_points = trail_points.filter(func(p): return now - p[1] < trail_lifetime)
	
	trail.clear_points()
	for point in trail_points:
		trail.add_point(point[0])
	
	var gradient = Gradient.new()
	gradient.set_color(0, Color(1, 1, 1, 0))
	gradient.set_color(1, Color(1.0, 1.0, 1.0, 1.0))
	trail.gradient = gradient

func fire():
	if swinging == false:
		swinging = true
		_swing()

func _swing():
	var tween = create_tween()
	var swing_angle = deg_to_rad(-145) if %Sword_Pivot.scale.x == 1 else deg_to_rad(145)
	var return_angle = deg_to_rad(-160) if %Sword_Pivot.scale.x == 1 else deg_to_rad(160)
	tween.tween_method(func(angle): %Sword_Pivot.rotation = angle,
		%Sword_Pivot.rotation, swing_angle, 0.2)
	tween.tween_method(func(angle): %Sword_Pivot.rotation = angle,
		return_angle, 0.0, 0.2)
	tween.tween_callback(func(): swinging = false)
	
func look_at_mouse(delta: float) -> void:
	# Get all sprites
	var direction = get_global_mouse_position() - global_position
	var target_angle = direction.angle()
	rotation = lerp_angle(rotation, target_angle, weapon_rotation_weight * delta)
	
	var weapon_rotation = wrapf(global_rotation_degrees, -180, 180)
	
	if weapon_rotation > -90 and weapon_rotation < 90:
		%Sword_Pivot.scale = Vector2(-1, -1)
	else:
		%Sword_Pivot.scale = Vector2(1, 1)
		
