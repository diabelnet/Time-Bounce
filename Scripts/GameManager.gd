extends Node

var controlls: int = 1
var player:CharacterBody2D

@export var curr_lvl:int = 1
var game_ended:=false

var recordedInteraction:Array[keyValuePair]
var is_recording := false
var inputted = false

var curr_clone = 1

func empty():
	pass

func next_level():
	curr_clone =1
	curr_lvl += 1
	get_tree().change_scene_to_file("res://Scenes/level_" + str(curr_lvl) + ".tscn")
	recordedInteraction.clear()
	var inputted = false
