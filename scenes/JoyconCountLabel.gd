extends Label


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

func displayJoyconCount(count:int):
	text = "Connected Joycons: " + str(count)


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_Button2_pressed():
	displayJoyconCount(2)
	pass # Replace with function body.
