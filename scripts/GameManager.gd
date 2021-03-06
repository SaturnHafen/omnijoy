extends Spatial

const TIME_TO_KILL = 100

# these values will be set after spawn
var timer
var timerProgressBar
var timeLeftText

var deathCount = 0

var manager = preload("res://JoyCons/JoyConManager.gd").new()
export var sceneLvl1 = preload("res://scenes/CanyonLowPoly.tscn")
export var sceneLvl2 = preload("res://scenes/CanyonHighPoly.tscn")

var omnidroid = load("res://scenes/omnidroid.tscn")
var current_scene: Node
var current_droid: Node
var current_lvlNumber:int
var joyconCount:int

# Called when the node enters the scene tree for the first time.
func _ready():
	joyconCount = manager.init_devices()
	#if joyconCount < 4:
	#	assert(false, "There must be 4 JoyCons")
	
	$MainMenu/VBoxContainer/JoyconCountLabel.displayJoyconCount(joyconCount)
	


func _process(delta):
	if is_instance_valid(timer):
		timerProgressBar.value = timer.time_left
		var styleBox = timerProgressBar.get("custom_styles/fg")
		var r = 1 - timerProgressBar.value / timerProgressBar.max_value
		var g = timerProgressBar.value / timerProgressBar.max_value
		styleBox.bg_color = Color(r, g, 0)
		
		if timer.time_left == 0:
			game_over()
		
	if is_instance_valid(timeLeftText):
		timeLeftText.text = 'TIME TO KILL: ' + str(int(timerProgressBar.value))


func initialize_main_scene(lvlScene):
	current_scene = lvlScene.instance()
	$MenuMusic.stop()
	add_child(current_scene)
	spawn_droid()

func spawn_droid():
	var spawn_point = current_scene.get_node("spawn").translation
	
	var droid: Spatial = omnidroid.instance()
	add_child(droid)
	droid.translation = spawn_point
	droid.get_node("mesh").init(manager)
	current_droid = droid
	
	timer = droid.get_node("Camera/playerInfo/Timer")
	timerProgressBar = droid.get_node("Camera/playerInfo/TimerProgressBar")
	timeLeftText = droid.get_node("Camera/playerInfo/TimeLeftText")
	timer.wait_time = TIME_TO_KILL
	timerProgressBar.min_value = 0
	timerProgressBar.max_value = TIME_TO_KILL
	timer.start()
	droid.get_node("Camera/playerInfo/DeathCount").text = 'death count: ' + str(deathCount)

func game_over():
	current_scene.queue_free()
	current_droid.queue_free()
	
	deathCount += 1
	$ReloadTimer.start()
	
func game_won():
	print("You win!")
	$MainMenu/VBoxContainer/Label.text = "Incredible!"
	showMenu(true)
	$MenuMusic.play()
	$omnidroidHappy.play()
	current_scene.queue_free()
	current_droid.queue_free()
	
	
func showMenu(show:bool):
	$MainMenu.visible = show
	
	
	
func loadLvl1():
	showMenu((false))
	current_lvlNumber = 1
	initialize_main_scene(sceneLvl1)
	
func loadLvl2():
	showMenu(false)
	current_lvlNumber = 2
	initialize_main_scene(sceneLvl2)


func _on_ReloadTimer_timeout():
	if current_lvlNumber == 1:
		initialize_main_scene(sceneLvl1)
	else:
		initialize_main_scene(sceneLvl2)

