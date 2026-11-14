extends AnimatedSprite2D

var open:bool = false
var inside:bool = false
@onready var area_2d: Area2D = $Area2D

func interact():
	print("interacted")
	self.play("open")
	open = true

func _on_area_2d_body_entered(body: Node2D) -> void:
	inside = true
	
func _on_area_2d_body_exited(body: Node2D) -> void:
	inside = false

func _input(event: InputEvent) -> void:
	if(inside && open):
		if(event.is_action_pressed("Interact_" + str(GameManager.controlls))):
			GameManager.next_level()
