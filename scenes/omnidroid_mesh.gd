extends Spatial

var manager = preload("res://JoyCons/JoyConManager.gd").new()

func _ready():
	$Skeleton/ik_back.start()
	$Skeleton/ik_front.start()
	$Skeleton/ik_left.start()
	$Skeleton/ik_right.start()
	
	if manager.init_devices() < 4:
		assert(false, "There must be 4 JoyCons")
	
	$front.init(manager, 0)
	$back.init(manager, 1)
	$left.init(manager, 2)
	$right.init(manager, 3)
