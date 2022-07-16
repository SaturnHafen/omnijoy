extends Spatial

var manager = preload("res://JoyCons/JoyConManager.gd").new()

var committed_rollers = {
	player0 = false,
	player1 = false,
	player2 = false,
	player3 = false,
}

func _ready():
	print("robot._init()")
	for index in manager.init_devices():
		get_node("Player" + str(index)).init(manager, index)

func try_start_rolling():
	pass

func _on_Player0_rolling():
	committed_rollers["player0"] = true
	try_start_rolling()

func _on_Player1_rolling():
	committed_rollers["player1"] = true
	try_start_rolling()

func _on_Player2_rolling():
	committed_rollers["player2"] = true
	try_start_rolling()

func _on_Player3_rolling():
	committed_rollers["player3"] = true
	try_start_rolling()

func _on_RollingTimer():
	pass
