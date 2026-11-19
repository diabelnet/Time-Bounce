@abstract

## For this class to work correctly you need: [br]
## func logic(), func resetInteraction [br]
## !!! If you want to use _ready() you need to add super() for it to work !!!
class_name Target
extends Node

@export var interactionsRequired:int
var activeInterfaces:Array[Interface]

## only increments during recording and after that it resets
var recordingActiveIntefaces:Array[Interface]

## value of 0 means that the interfaces won't reset 
@export var timeToReset:float

var collider:Area2D

func _ready() -> void:
	collider = get_node("Collider")

func interact(interface:Interface):
	interface.enabled = false
	
	if timeToReset != 0:
		for i in activeInterfaces:
			get_tree().create_timer(timeToReset).timeout.connect(resetInterface(interface))
	
	if GameManager.is_recording:
		recordingActiveIntefaces.append(interface)
		GameManager.recordedInteraction.append(keyValuePair.new(interface,self))
		GameManager.inputted = true
	else:
		activeInterfaces.append(interface)
	
	if activeInterfaces.size() + recordingActiveIntefaces.size() >= interactionsRequired:
		logic()

func _input(event: InputEvent) -> void:
	if event.is_action("Interact_" +  str(GameManager.controlls)):
		if activeInterfaces.size() >= interactionsRequired:
			if GameManager.player == null:
				print("Player not found")
				return
		
			if collider.overlaps_body(GameManager.player):
				GameManager.next_level()
	
## Resets recording interfaces; executed at the end of the recording
func reset():
	for inter in recordingActiveIntefaces:
		if activeInterfaces.count(inter) <= 0:
			inter.enabled = true
			inter.reset()
	
	recordingActiveIntefaces = []
	
	if activeInterfaces.size() < interactionsRequired:
		resetInteraction()
		
## Function called to reset an specific interface
func resetInterface(interface:Interface):
	interface.enabled = true
	
	if activeInterfaces.size() < interactionsRequired:
		resetInteraction()

## Abstract function that's executed after an interaction if the number of active interfaces is equal of higher to the number needed
@abstract func logic()

## Abstract function that's executed after if the there's not enougth interfaces to meet the required amount [br]
## It's executed after the recording ends and when an interface is reset
@abstract func resetInteraction()
