extends AnimatedSprite2D

@onready var area_2d: Area2D = $Area2D

@export var input_name:String
@export var repeat_flicker = 4
@export var resets:bool
@export var time_to_reset:float
@export var target:AnimatedSprite2D

var interactable:bool = true
var curr_flicker = 0
func interact():
	interactable = false
	if(curr_flicker < repeat_flicker):
		curr_flicker += 1
		self.play("flicker")
		await self.animation_finished
		interact()
	else:
		self.play("anim")
		await self.animation_finished
		if(resets):
			var timer = get_tree().create_timer(time_to_reset)
			timer.timeout = reset
		print(target)
		target.interact()
	
func _on_area_2d_body_entered(body: Node2D) -> void:
	if(interactable && body.name == "Player"):
		GameManager.action = [input_name + 
		str(GameManager.controlls),interact]

func _on_area_2d_body_exited(body: Node2D) -> void:
	if(body.name == "Player"):
		GameManager.action = [null,null]

func reset():
	curr_flicker = 0
	interactable = true
