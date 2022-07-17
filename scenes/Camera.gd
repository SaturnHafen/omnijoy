extends Camera

export var target: NodePath
export var camera_distance: int = 8
export var camera_height: int = 5

func _physics_process(delta):
	var target_parent = get_node(target)
	var target_transform = target_parent.get_node("body").global_transform
	var forward = Vector3(1, 0, 1) * target_transform.basis.x
	var target_position = target_transform.origin - camera_distance * forward + Vector3(0, camera_height, 0)
	global_translate(0.002 * (target_position - global_transform.origin))
	look_at(target_transform.origin, Vector3.UP)
