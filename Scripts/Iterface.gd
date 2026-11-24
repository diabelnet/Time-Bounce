@abstract

## For it to work you need: [br]
## func reset()
## !!! If you want to use _ready() you need to add super() for it to work !!!
class_name Interface
extends Node

@export var targets:Array[Target]
var collider:Area2D
var enabled:bool = true

func _ready() -> void:
	collider = get_node("Collider")

func _input(event: InputEvent) -> void:
	if !enabled:
		return
	
	if GameManager.player == null:
		print("Player not found")
		return
		
	if collider.overlaps_body(GameManager.player):
		if event.is_action_pressed("Interact_" + str(GameManager.controlls)):
			for t in targets:
				if t != null:
					t.interact(self)
			interact()

## Function called when the interface is reset
@abstract func reset()

## Function called when the interface is interacted with
func interact():
	pass
