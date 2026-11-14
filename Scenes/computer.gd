extends AnimatedSprite2D

@onready var area_2d: Area2D = $Area2D
@export var input_name:String

@export var repeat_flicker = 4
var curr_flicker = 0
func interact():
	if(curr_flicker < repeat_flicker):
		curr_flicker += 1
		self.play("flicker")
		await self.animation_finished
		interact()
	else:
		self.play("anim")
	
func _on_area_2d_body_entered(body: Node2D) -> void:
	GameManager.action = [input_name + str(GameManager.controlls),interact]

func _on_area_2d_body_exited(body: Node2D) -> void:
	GameManager.action = [null,null]
