extends Node

var controlls: int = 1
var player:CharacterBody2D

@export var curr_lvl:int = 1
var game_ended:=false
## [0] - String: Name of the Input Action [br]
## [1] - Callable: Function to call [br]
## creating Callable: Calllable([Function_name]) [br]
## calling the function: action[1].call() 
var action:Array = [null,null]
var actionClone:Callable
var is_recording := false

var curr_clone = 1

func empty():
	pass

func next_level():
	curr_clone =1
	curr_lvl += 1
	get_tree().change_scene_to_file("res://Scenes/level_" + str(curr_lvl) + ".tscn")
	action = [null,null]
	actionClone = Callable(empty)
	
