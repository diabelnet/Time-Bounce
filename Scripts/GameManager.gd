extends Node

var controlls: int = 1
var player:CharacterBody2D

@export var curr_lvl:int = 1

## [0] - String: Name of the Input Action [br]
## [1] - Callable: Function to call [br]
## creating Callable: Calllable([Function_name]) [br]
## calling the function: action[1].call() 
var action:Array = [null,null]
var actionClone:Array = []
var is_recording := false

func next_level():
	print("loading next level")
