extends Spatial

signal start_rolling

var rollers = {
	left = false,
	right = false,
	front = false,
	back = false,
}

var rolling_allowed = true
var rolling = false

export var rolling_speed: int = 400

func _ready():
	$body/Skeleton/ik_back.start()
	$body/Skeleton/ik_front.start()
	$body/Skeleton/ik_left.start()
	$body/Skeleton/ik_right.start()
	$body.linear_damp = 4
	$body.angular_damp = 5

func init(manager):
	$front.init(manager, 0)
	$back.init(manager, 1)
	$left.init(manager, 2)
	$right.init(manager, 3)

func _physics_process(delta):
	if not rolling:
		var body_transform = $body.global_transform
		var offset_scale = 0.2
		for arm_offset in [[$front, Vector2(1, 0)], [$back, Vector2(-1, 0)], [$left, Vector2(0, -1)], [$right, Vector2(0, 1)]]:
			var arm = arm_offset[0]
			var offset = arm_offset[1]
			var center = body_transform.origin
			var socket_offset = \
				offset.x * body_transform.basis.x * offset_scale + \
				offset.y * body_transform.basis.y * offset_scale
			var socket = center + socket_offset
			var foot = arm.global_transform.origin
			var direction = socket - foot
			var length = direction.length()
			var goal_distance = 4
			var strength = goal_distance - length
			strength = sign(strength) * pow(abs(strength), 2.5) * 60
			var force = direction.normalized() * strength
			$body.add_central_force(force)

func _on_body_collide(body):
	print("you die (body)!")

func try_start_rolling():
	print("trying to roll...")
	
	if $TryRollingTimer.is_stopped():
		$TryRollingTimer.start()

	var start_rolling: bool = true
	for roller in rollers.values():
		start_rolling = start_rolling and roller
		
	print(rollers)
		
	if start_rolling:
		emit_signal("start_rolling")
		print("Start rolling")
		rolling_allowed = false
		rolling = true
		
		$Rolling.start()
		hide_arms()
		$body.add_central_force(Vector3(rolling_speed, 0, 0))

func _on_front_try_rolling():
	if rolling_allowed:
		rollers["front"] = true
		try_start_rolling()

func _on_back_try_rolling():
	if rolling_allowed:
		rollers["back"] = true
		try_start_rolling()

func _on_left_try_rolling():
	if rolling_allowed:
		rollers["left"] = true
		try_start_rolling()

func _on_right_try_rolling():
	if rolling_allowed:
		rollers["right"] = true
		try_start_rolling()

func _on_TryRollingTimer_timeout():
	rollers = {
		left = false,
		right = false,
		front = false,
		back = false,
	}

func _on_RollingTimeout_timeout():
	rolling_allowed = true
	

func hide_arms():
	$front/Indicator.visible = false
	$back/Indicator.visible = false
	$left/Indicator.visible = false
	$right/Indicator.visible = false
	
	$body/Skeleton.visible = false

func show_arms():
	$front/Indicator.visible = true
	$back/Indicator.visible = true
	$left/Indicator.visible = true
	$right/Indicator.visible = true
	
	$body/Skeleton.visible = true

func reposition_arms():
	$front.translation = $body.translation + Vector3(2.482, 0, 0)
	$back.translation = $body.translation + Vector3(-2.482, 0, 0)
	$left.translation = $body.translation + Vector3(0, 2.482, 0)
	$right.translation = $body.translation + Vector3(0, -2.482, 0)
	
	$body.rotation_degrees = Vector3.ZERO
	$body.angular_velocity = Vector3.ZERO
	$body.linear_velocity = Vector3.ZERO
	
func _on_Rolling_timeout():
	reposition_arms()
	show_arms()
	rolling = false
	$RollingTimeout.start()
