extends Spatial


export var lower_trigger: float = 0.2
export var hight_trigger: float = 0.8

export var movement_speed: float = 5

signal try_rolling
signal move(acceleration)

var triggered = false
var motion_allowed = true

func init(manager, joycon_id):
	print("player._init()")
	$JoyCon.set_controller(joycon_id, manager)
		
	var material = SpatialMaterial.new()
	material.albedo_color = $JoyCon.color
	
	for i in $Cube.mesh.get_surface_count():
		$Cube.set_surface_material(i, material)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var acceleration = $JoyCon.linear_accel
	acceleration *= Vector3(1, 0, 1)
	
	if motion_allowed and not triggered and acceleration.length_squared() > pow(hight_trigger, 2):
		emit_signal("move", acceleration)
		var target_position = $Cube.translation + acceleration * (Vector3(1, 0, 1) * movement_speed)
		$Tween.interpolate_property($Cube, "translation", $Cube.translation, target_position, 0.5, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
		$Tween.start()
				
		$Cube.mesh
		
		$JoyCon.rumble(5, 1)
		triggered = true
		motion_allowed = false
		$MotionControlTimeout.start()
		
	if acceleration.length_squared() < pow(lower_trigger, 2):
		triggered = false


func _on_joycon_button_pressed(button_name):
	if button_name == 'math':
		$Cube.translation = Vector3()
		
	elif button_name == 'joystick': # do detaching
		pass

	elif button_name == 'z': # check if rolling
		emit_signal("try_rolling")


func _on_MotionControlTimeout():
	motion_allowed = true
