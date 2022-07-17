extends Camera

export var target: NodePath

onready var current_look_at: Vector3 = get_target_transform().origin

var offset: Vector2 = Vector2(8, 5)
var position_lag: float = 0.002
var rotation_lag: float = 0.04

func get_target_transform():
	return get_node(target).get_node("body").global_transform

func _physics_process(delta):
	var target_transform = get_target_transform()
	var forward = Vector3(1, 0, 1) * target_transform.basis.x
	var target_position = target_transform.origin - offset.x * forward + Vector3(0, offset.y, 0)
	global_translate(position_lag * (target_position - global_transform.origin))

	current_look_at = current_look_at.linear_interpolate(target_transform.origin, rotation_lag)
	look_at(current_look_at, Vector3.UP)
