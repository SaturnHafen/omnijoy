extends Spatial

var manager = preload("res://JoyCons/JoyConManager.gd").new()
var scene = load("res://scenes/omnidroid.tscn")
var current_instance: Node

# Called when the node enters the scene tree for the first time.
func _ready():
	if manager.init_devices() < 4:
		assert(false, "There must be 4 JoyCons")
	
	initialize_main_scene()


func initialize_main_scene():
	current_instance = scene.instance()
	add_child(current_instance)
	
	print(current_instance)
	
	current_instance.get_node("mesh").init(manager)
	
func game_over():
	current_instance.queue_free()
	initialize_main_scene()

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
