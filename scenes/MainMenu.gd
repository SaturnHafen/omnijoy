extends Control

onready var GameManager:Spatial = get_tree().get_root().get_node("Game")

# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	
	print("Test ist Gamemanager geladen: ", GameManager)
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_Button_pressed():##Start Button
	GameManager.initialize_main_scene()
	


func _on_Button2_pressed_options():
	pass # Replace with function body.
