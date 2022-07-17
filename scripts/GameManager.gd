extends Spatial

var manager = preload("res://JoyCons/JoyConManager.gd").new()
export var scene = preload("res://scenes/CanyonLowPoly.tscn")
var omnidroid = load("res://scenes/omnidroid.tscn")
var current_scene: Node
var current_droid: Node

# Called when the node enters the scene tree for the first time.
func _ready():
	if manager.init_devices() < 4:
		assert(false, "There must be 4 JoyCons")
	
	initialize_main_scene()


func initialize_main_scene():
	current_scene = scene.instance()
	add_child(current_scene)
	print(current_scene)
	
	spawn_droid()
	
func spawn_droid():
	var spawn_point = current_scene.get_node("spawn").translation
	
	var droid: Spatial = omnidroid.instance()
	add_child(droid)
	droid.translation = spawn_point
	droid.get_node("mesh").init(manager)
	current_droid = droid
	
func game_over():
	current_scene.queue_free()
	current_droid.queue_free()
	initialize_main_scene()

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
