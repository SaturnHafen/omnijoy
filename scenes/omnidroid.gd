extends Spatial

func _ready():
	for arm in [$mesh/front, $mesh/back, $mesh/left, $mesh/right]:
		arm.reference_frame = arm.get_path_to($Camera)
