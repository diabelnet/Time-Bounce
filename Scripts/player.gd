extends CharacterBody2D

const SPEED = 300.0
const JUMP_VELOCITY = -400.0

@onready var clonePacked:PackedScene = load("res://Scenes/clone.tscn")

var controlls:int = GameManager.controlls

var isRecording:bool = false
var recording:Array = []

var instance:CharacterBody2D = null

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
		
	if isRecording:
		recording.append([delta, jump])
		recording.append([delta, direction])

	move_and_slide()
	
func _input(event: InputEvent) -> void:
	if(event.is_action("Record_Clone_" + str(controlls))):
		record()
	if(event.is_action("Play_Clone_" + str(controlls))):
		if(event.is_action_pressed("Play_Clone_" + str(controlls), false)):
			play()

func record() -> void:
	isRecording = true
	recording = []
	
func play() -> void:
	if(instance != null):
		instance.free()
	instance = clonePacked.instantiate()
	instance.position = Vector2(0, -50)
	self.add_sibling(instance)
	
	GameManager.recording = recording
