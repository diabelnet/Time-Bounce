extends Node

#opis uzywania replay:
#replay jest klasa ktorej w inspektorze dajesz node jakiego ma nagrywac
# record() nagrywa pozycje objetu oraz to czy input bylo klikniete
# play(can_activate) can_activate = default true ; tworzy klona i on wykonuje nagrane ruchy
# return_to_orginal_pos() zwraca gracza na swoja orginalna pozycje
# reset() resetuje ta klase

#trust that it works

class_name replay

@export var recorded_obj : Node2D
var cloneScene := load("res://Scenes/clone.tscn") 

signal player_input

var frame := 0
var record_data = [{},{},{},{}]
var first_pos : Vector2
var is_first_pos_there := false #do sprawdzenia czy pierwsza pozycja byla juz pobrana

func record():
	if(frame == 0):
		first_pos = recorded_obj.global_position
	
	record_data[GameManager.curr_clone][frame] = {'pos' : recorded_obj.global_position, 'input' : Input.is_action_pressed("Interact_" + str(GameManager.controlls))} #np. record_data[0]['pos'] = Vector2(), lua syntax

	frame +=1
	
var instances:Array[CharacterBody2D] = [null, null, null, null]
var currentAction = 0
func play(can_activate:bool):
	print(GameManager.curr_clone)
	if record_data[GameManager.curr_clone] and can_activate:
		if(instances[GameManager.curr_clone] != null):
			instances[GameManager.curr_clone].queue_free()
		var clone = cloneScene.instantiate() 
		instances[GameManager.curr_clone] = clone
		add_child(clone)
		var tween = clone.create_tween()
		tween.tween_property(clone, 'global_position', record_data[GameManager.curr_clone][0]['pos'], 0.1).from(record_data[GameManager.curr_clone][0]['pos'])
		currentAction = 0
		for i in frame:
			tween.tween_property(clone, 'global_position', record_data[GameManager.curr_clone][i]['pos'], 0.1)
			if record_data[GameManager.curr_clone][i]['input'] == true:
				GameManager.actionClone[currentAction][GameManager.curr_clone][0].call()
				currentAction += 1
		return true
				
func return_to_orginal_position():
	recorded_obj.global_position = first_pos
	
func reset():
	frame = 0
	record_data[GameManager.curr_clone] = {}
	first_pos = Vector2(0,0)
	is_first_pos_there = false

func is_recorded():
	if record_data[GameManager.curr_clone]:
		return true
