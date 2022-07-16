extends RigidBody

var speed:float = 20

var lives: int = 3

onready var _playerLivesLabel = $TestSpringArm/Camera/playerInfo/lives


# Called when the node enters the scene tree for the first time.
func _ready():
	_reloadPlayerInfo()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	#_spring_arm.translation = translation
	#print(translation)
	_move()


### MOVEMENT

func _move():
	var forceToAdd:Vector3 = Vector3.ZERO
	
	if Input.is_action_pressed("ui_left"):
		forceToAdd += Vector3.LEFT
	if Input.is_action_pressed("ui_down"):
		forceToAdd += Vector3.BACK
	if Input.is_action_pressed("ui_right"):
		forceToAdd += Vector3.RIGHT
	if Input.is_action_pressed("ui_up"):
		forceToAdd += Vector3.FORWARD #Ist Vekot (0,0,-1)
	
	forceToAdd = forceToAdd.rotated(Vector3.UP, rotation.y)
	forceToAdd = forceToAdd.normalized()
	
	if forceToAdd != Vector3.ZERO:
		add_central_force(forceToAdd * speed )


### COLLISIONS

func _reloadPlayerInfo():
	_playerLivesLabel.set_text('Lives: %s' % str(lives))


func _handleStoneCollision():
	lives -= 1
	_reloadPlayerInfo()


func _on_playerThing_body_entered(body):
	if body.is_in_group('DamagingObstacles'):
		_handleStoneCollision()
