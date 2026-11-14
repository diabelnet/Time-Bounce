extends CharacterBody2D

const SPEED = 140
const JUMP_VELOCITY = -350

var controlls:int = GameManager.controlls
var anim:AnimatedSprite2D

func _physics_process(delta: float) -> void:
	if not is_on_floor():
		velocity += get_gravity() * delta

	var jump = Input.is_action_just_pressed("Jump")

	if jump and is_on_floor():
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
	
func _ready() -> void:
	anim = get_node("AnimatedSprite2D")
	GameManager.player = self
