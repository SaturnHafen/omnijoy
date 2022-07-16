extends Spatial

var manager = preload("res://JoyCons/JoyConManager.gd").new()

func _ready():
	$body/Skeleton/ik_back.start()
	$body/Skeleton/ik_front.start()
	$body/Skeleton/ik_left.start()
	$body/Skeleton/ik_right.start()
	
	if manager.init_devices() < 4:
		assert(false, "There must be 4 JoyCons")

	$front.init(manager, 0)
	$back.init(manager, 1)
	$left.init(manager, 2)
	$right.init(manager, 3)

func _physics_process(delta):
	$body.add_central_force($body.linear_velocity * -2)
	for arm in [$front, $back, $left, $right]:
		var target = $body.global_transform.origin
		var source = arm.global_transform.origin
		var direction = target - source
		var length = direction.length()
		var goal_distance = 4
		var strength = goal_distance - length
		strength = sign(strength) * pow(abs(strength), 2.5) * 60
		var force = direction.normalized() * strength
		$body.add_central_force(force)
