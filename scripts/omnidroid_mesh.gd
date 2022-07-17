extends Spatial


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
