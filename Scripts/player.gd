extends CharacterBody2D

const SPEED = 300.0
const JUMP_VELOCITY = -400.0

var controlls:int = GameManager.controlls

func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta

	var jump = Input.is_action_just_pressed("Jump")

	# Handle jump.
	if jump and is_on_floor():
		velocity.y = JUMP_VELOCITY

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay 

	var direction := Input.get_axis("Right_"+str(controlls), "Left_"+str(controlls))
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)

	move_and_slide()
	
func _input(event: InputEvent) -> void:
	if(event.is_action_pressed("Record_Clone_" + str(controlls))):
		GameManager.recording = true
		GameManager.record()
		
	if(event.is_action_pressed("Play_Clone_" + str(controlls), false)):
			GameManager.play()
	
	if(GameManager.action[0] != null):
		if(event.is_action_pressed(GameManager.action[0])):
			GameManager.action[1].call()
	
func _ready() -> void:
	GameManager.player = self
