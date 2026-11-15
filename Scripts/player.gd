extends CharacterBody2D

const SPEED = 140
const JUMP_VELOCITY = -325

var controlls:int = GameManager.controlls
var anim:AnimatedSprite2D
var audio:AudioStreamPlayer2D

var just_jumped:bool = false

func _physics_process(delta: float) -> void:
	if not is_on_floor():
		velocity += get_gravity() * delta
	else:
		if(just_jumped):
			audio.stream = preload("uid://c2sam7xk5y0ma") # Land sound
			audio.play()
			just_jumped = false

	var jump = Input.is_action_just_pressed("Jump")

	if jump and is_on_floor():
		audio.stream = preload("uid://b3pht6r6lt810") # Jump sound
		audio.play()
		just_jumped = true
		velocity.y = JUMP_VELOCITY

	var direction := Input.get_axis("Right_"+str(controlls), "Left_"+str(controlls))
	if direction:
		velocity.x = direction * SPEED
		anim.play("walking")
		
		anim.flip_h = false
		if(direction < 0):
			anim.flip_h = true
		
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		anim.play("idle")

	move_and_slide()
	
func _input(event: InputEvent) -> void:
	if(GameManager.action[0] != null):
		if(event.is_action_pressed(GameManager.action[0])):
			GameManager.action[1].call()
			
	if(event.is_action_pressed("Restart")):
			get_tree().reload_current_scene()
			GameManager.action = [null,null]
			GameManager.actionClone = GameManager.empty
			
	if(event.is_action_pressed("Clone_1_" + str(GameManager.controlls)) and !GameManager.is_recording):
		GameManager.curr_clone = 0
		get_tree().call_group('UI', 'now_active', 1)
	if(event.is_action_pressed("Clone_2_" + str(GameManager.controlls)) and !GameManager.is_recording):
		if(GameManager.curr_lvl >= 2):
			GameManager.curr_clone = 1
			get_tree().call_group('UI', 'now_active', 2)
	if(event.is_action_pressed("Clone_3_" + str(GameManager.controlls)) and !GameManager.is_recording):
		if(GameManager.curr_lvl >= 3):
			GameManager.curr_clone = 2
			get_tree().call_group('UI', 'now_active', 3)
	if(event.is_action_pressed("Clone_4_" + str(GameManager.controlls)) and !GameManager.is_recording):
		if(GameManager.curr_lvl >= 4):
			GameManager.curr_clone = 3
			get_tree().call_group('UI', 'now_active', 4)
	
func _ready() -> void:
	anim = get_node("AnimatedSprite2D")
	audio = get_node("AudioStreamPlayer2D")
	GameManager.player = self
