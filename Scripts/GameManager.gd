extends Node
var controlls: int = 1
var player:CharacterBody2D

@export var DEBUG := true

@export var curr_lvl:int = 1
var game_ended:=false

var recordedInteraction:Array[keyValuePair]

var is_recording := false
var inputted := false
var currentInputRecording := 0

var curr_clone = 0

func emptyCallable():
	pass

func next_level():
	curr_clone =1
	curr_lvl += 1
	recordedInteraction.clear()
	currentInputRecording = 0
	inputted = false
	var error := get_tree().change_scene_to_file("res://Scenes/level_" + str(curr_lvl) + ".tscn")
	if error == ERR_CANT_OPEN:
		get_tree().change_scene_to_file("res://Scenes/menu.tscn")
		game_ended = true
