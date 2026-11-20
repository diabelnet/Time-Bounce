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

@warning_ignore("unused_signal") signal player_input

var instances:Array[CharacterBody2D] = [null, null, null, null]
var currentAction = 0

var frame := 0
var record_data = [{},{},{},{}]
var first_pos : Vector2
var is_first_pos_there := false #do sprawdzenia czy pierwsza pozycja byla juz pobrana

func record():
	if(frame == 0):
		first_pos = recorded_obj.global_position
	
	record_data[GameManager.curr_clone][frame] = {'pos' : recorded_obj.global_position, 'input' : GameManager.inputted} #np. record_data[0]['pos'] = Vector2(), lua syntax
	GameManager.inputted = false
	frame +=1
	
func play(can_activate:bool):
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
				var callable := Callable(self, "recorderInteractionCallable")
				callable = callable.bind(currentAction)
				get_tree().create_timer(0.1 * i).connect("timeout", callable)
				currentAction += 1
		return true
				
func recorderInteractionCallable(action):
	for v in GameManager.recordedInteraction[action].value:
		v.interact(GameManager.recordedInteraction[action].key)
	GameManager.recordedInteraction[action].key.interact()

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
