extends AnimatedSprite2D

var open:bool = false
var inside:bool = false
@onready var area_2d: Area2D = $Area2D
@export var comp_needed:int
var active: int = 0

func interact():
	print(str(active) + " : " + str(comp_needed))
	active += 1
	if(active >= comp_needed):
		self.play("open")
		open = true
	
func reset():
	active -= 1
	if(active >= comp_needed):
		if(!open):
			self.play("open")
			open = true
	else:
		self.play("default")
		open = false

func _on_area_2d_body_entered(body: Node2D) -> void:
	inside = true
	
func _on_area_2d_body_exited(body: Node2D) -> void:
	inside = false
	
var old_open
func save():
	old_open = open

func load():
	open = old_open

func _input(event: InputEvent) -> void:
	if(inside && open):
		if(event.is_action_pressed("Interact_" + str(GameManager.controlls))):
			GameManager.next_level()
