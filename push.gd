extends Spatial

func _physics_process(delta):
	$RigidBody.add_central_force($RigidBody.linear_velocity * -2)
	for actor in [$one, $two, $three, $four]:
		var target = $RigidBody.translation
		var source = actor.translation
		var direction = target - source
		var length = direction.length()
		var goal_distance = 4
		var strength = goal_distance - length
		strength = sign(strength) * pow(abs(strength), 2.5) * 60
		var force = direction.normalized() * strength
		$RigidBody.add_central_force(force)
		#print(force)
		
