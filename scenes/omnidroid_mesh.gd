extends Spatial

func _ready():
	$Skeleton/ik_back.start()
	$Skeleton/ik_front.start()
	$Skeleton/ik_left.start()
	$Skeleton/ik_right.start()
	
