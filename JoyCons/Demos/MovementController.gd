extends RigidBody

var speed:float = 20

onready var _spring_arm: SpringArm = $SpringArm

# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	_spring_arm.translation = translation
	#print(translation)
	
	var forceToAdd:Vector3 = Vector3.ZERO
	
	if Input.is_action_pressed("ui_left"):
		forceToAdd += Vector3.LEFT
	if Input.is_action_pressed("ui_down"):
		forceToAdd += Vector3.BACK
	if Input.is_action_pressed("ui_right"):
		forceToAdd += Vector3.RIGHT
	if Input.is_action_pressed("ui_up"):
		forceToAdd += Vector3.FORWARD
		
	if forceToAdd != Vector3.ZERO:
		add_central_force(forceToAdd * speed )


	
	#add_central_force(-0.4* linear_velocity)