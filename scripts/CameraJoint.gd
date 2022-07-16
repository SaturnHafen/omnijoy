extends SpringArm


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


#onready var camerarRefrence:Camera = $Camera
# Called when the node enters the scene tree for the first time.
func _ready():
	
	set_as_toplevel(true)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
	#print($Camera.translation)
	#$Camera.translation.x = 10
	#$Camera.translation.y = 10
	#$Camera.translation.z = 10
