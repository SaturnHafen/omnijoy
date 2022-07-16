extends KinematicBody


export var lower_trigger: float = 0.2
export var hight_trigger: float = 0.8

export var movement_speed: float = 5

signal try_rolling

var triggered: bool = false
var motion_allowed: bool = true
var animation_timer: float = 0
var current_from: Vector3
var current_to: Vector3 
var current_acceleration: Vector3 = Vector3(0, 0, 0)

export var animation_duration: float = 0.5
export var gravity: float = -0.5
var accum_gravity: float = 0

export var curve: Curve
export var curve_height: float = 0.25

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
func _physics_process(delta: float):
	
	if animation_timer > 0:
		animation_timer -= delta
		var time = 1 - (animation_timer / animation_duration)
		var to = current_from.linear_interpolate(current_to, time)
		var height = curve_height * (current_to - current_from).length()
		to.y += height * curve.interpolate(time)
		var velocity = to - global_transform.origin
		var collision = move_and_collide(velocity)
		if collision:
			handle_collision(collision)
		accum_gravity = 0
	else:
		if global_transform.origin.y > 0:
			accum_gravity += delta * gravity
			if move_and_collide(Vector3(0, accum_gravity, 0)):
				accum_gravity = 0
		motion_allowed = true

func _process(delta):
	var acceleration = $JoyCon.linear_accel
	acceleration *= Vector3(1, 0, 1)
	
	if motion_allowed and not triggered and acceleration.length_squared() > pow(hight_trigger, 2):
		current_from = global_transform.origin
		current_to = current_from + acceleration
		print(current_from, current_to)
		animation_timer = animation_duration
		$JoyCon.rumble(5, 1)
		
		triggered = true
		motion_allowed = false
		$MotionControlTimeout.start()
		
	if acceleration.length_squared() < pow(lower_trigger, 2):
		triggered = false

func handle_collision(collision: KinematicCollision):
	if collision:
		animation_timer = 0
		if collision.collider.is_in_group("DamagingObstacles"):
			print("you die!")

func _on_joycon_button_pressed(button_name):
	if button_name == 'math':
		$Cube.translation = Vector3()
		
	elif button_name == 'joystick': # do detaching
		pass

	elif button_name == 'z': # check if rolling
		emit_signal("try_rolling")
