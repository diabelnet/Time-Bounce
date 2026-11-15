extends Node

#opis uzywania replay:
#replay jest klasa ktorej w inspektorze dajesz node jakiego ma nagrywac
# record() nagrywa pozycje objetu oraz to czy input bylo klikniete
# play(can_activate) can_activate = default true ; tworzy klona i on wykonuje nagrane ruchy

class_name replay

@export var recorded_obj : Node2D
var cloneScene := load("res://Scenes/clone.tscn") 

signal player_input
signal player_not_input


var frame = 0
var record_data = {}
var first_pos : Vector2

func record():
	if(frame == 0):
		first_pos = recorded_obj.global_position
	record_data[frame] = {'pos' : recorded_obj.global_position, 'input' : Input.is_action_pressed("Interact_" + str(GameManager.controlls))} #np. record_data[0]['pos'] = Vector2(), lua syntax
	#record_data[frame] = {'input' = Input.is_action_just_pressed("Interact_" + str(GameManager.controlls))} #zmien potem
	print(record_data[frame])
	frame +=1
	
	
func play(can_activate:bool):
	if record_data and can_activate:
		for c in get_children():
			c.queue_free()
		print(record_data)
		var clone = cloneScene.instantiate() 
		add_child(clone)
		var tween = clone.create_tween()
		tween.tween_property(clone, 'global_position', record_data[0]['pos'], 0.1).from(record_data[0]['pos'])
		for i in frame:
			tween.tween_property(clone, 'global_position', record_data[i]['pos'], 0.1)
			if record_data[i]['input'] == true:
				player_input.emit()
			else:
				player_not_input.emit()

func return_to_orginal_position():
	recorded_obj.global_position = first_pos

func reset():
	frame = 0
	record_data = {}
	first_pos = Vector2(0,0)
	
func is_recorded():
	if record_data:
		return true
