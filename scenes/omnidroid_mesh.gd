extends Spatial

func _ready():
	$Skeleton/ik_back.start()
	$Skeleton/ik_front.start()
	$Skeleton/ik_left.start()
	$Skeleton/ik_right.start()

func _on_Player0_move(acceleration):
	$front.translate(acceleration)

func _on_Player1_move(acceleration):
	$back.translate(acceleration)

func _on_Player2_move(acceleration):
	$left.translate(acceleration)

func _on_Player3_move(acceleration):
	$right.translate(acceleration)
