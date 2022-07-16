extends KinematicBody

export var enableKeybordControll:bool = false

export var lower_trigger: float = 0.2
export var hight_trigger: float = 0.8

export var movement_speed: float = 5

signal try_rolling

var triggered: bool = false
var motion_allowed: bool = true
var animation_timer: int = 0
var current_acceleration: Vector3 = Vector3(0, 0, 0)

export var animation_duration: int = 32

export var curve: Curve

func init(manager, joycon_id):
	print("player._init()")
	$JoyCon.set_controller(joycon_id, manager)
	
	var material = SpatialMaterial.new()
	var color: Color = $JoyCon.color
	color.a = 0.3
	material.albedo_color = color
	material.flags_transparent = true
	
	for i in $Cube.mesh.get_surface_count():
		$Cube.set_surface_material(i, material)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	
	if animation_timer > 0:
		animation_timer -= 1
		var time = 1 - (float(animation_timer) / animation_duration)
		var acceleration = current_acceleration / animation_duration
		var heigth = curve.interpolate(time)
		move_and_collide(acceleration)
		translation.y = heigth
	else:
		motion_allowed = true
	
	var acceleration = $JoyCon.linear_accel
	acceleration *= Vector3(1, 0, 1)
	
	if motion_allowed and not triggered:
		if acceleration.length_squared() > pow(hight_trigger, 2):
			startFootMovement(acceleration)
		if enableKeybordControll and (Input.is_action_pressed("ui_down") or Input.is_action_pressed("ui_left") or Input.is_action_pressed("ui_right") or Input.is_action_pressed("ui_up")):
			startFootMovement(getInputDirection())
	
	if acceleration.length_squared() < pow(lower_trigger, 2):
		triggered = false
		
func startFootMovement(acceleration:Vector3):
	current_acceleration = acceleration * Vector3(1, 0, 1)
	animation_timer = animation_duration
	$JoyCon.rumble(5, 1)
	
	triggered = true
	motion_allowed = false
	$MotionControlTimeout.start()
	
func getInputDirection()->Vector3:
	var inputDirection:Vector3 = Vector3.ZERO
	if (Input.is_action_pressed("ui_down")):
		inputDirection = Vector3.BACK
	if (Input.is_action_pressed("ui_up")):
		inputDirection = Vector3.UP
	if (Input.is_action_pressed("ui_left")):
		inputDirection = Vector3.LEFT
	if (Input.is_action_pressed("ui_right")):
		inputDirection = Vector3.RIGHT
	return inputDirection


func _on_joycon_button_pressed(button_name):
	if button_name == 'math':
		$Cube.translation = Vector3()
		
	elif button_name == 'joystick': # do detaching
		pass

	elif button_name == 'z': # check if rolling
		emit_signal("try_rolling")
