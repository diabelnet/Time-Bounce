@abstract

## For this class to work correctly you need: [br]
## func logic(), func resetInteraction() [br]
## contains an Area2D collider that's automatically set to a child node "Collider" in the _ready function [br]
## !!! If you want to use _ready() you need to add super() for it to work !!!
class_name Target
extends Node

@export var interactionsRequired:int
var activeInterfaces:Array[Interface]

## only increments during recording and after that it resets
var recordingActiveIntefaces:Array[Interface]

## value of 0 means that the interfaces won't reset 
@export var timeToReset:float

## if set to false stops executing the _input function
@export var inputEnabled:bool = true

## function that's called in the _input when pressed the interaction key and the interaction requirement is met
var inputCallable:Callable = GameManager.emptyCallable

## arguments for the inputCallable function
var inputCallableArguments:Array = []

## Targets collider
var collider:Area2D

func _ready() -> void:
	collider = get_node_or_null("Collider")
	if collider == null:
		push_warning(str(self) + " - Collider is null")

func interact(interface:Interface):
	interface.enabled = false
	
	if timeToReset != 0:
		for i in activeInterfaces:
			get_tree().create_timer(timeToReset).timeout.connect(resetInterface(interface))
	#print("---" + self.name + " - " + Time.get_datetime_string_from_system() + "---")
	if GameManager.is_recording:
		recordingActiveIntefaces.append(interface)
		if GameManager.recordedInteraction.size() > GameManager.currentInputRecording:
			GameManager.recordedInteraction[GameManager.currentInputRecording].value.append(self)
		else:
			GameManager.recordedInteraction.append(keyValuePair.new(interface, [self]))
		#GameManager.recordedInteraction.append(keyValuePair.new(interface,self))
		GameManager.inputted = true
	else:
		activeInterfaces.append(interface)

	#print("active: " +  str(activeInterfaces.size()))
	#print("req: " + str(interactionsRequired))
	if activeInterfaces.size() + recordingActiveIntefaces.size() >= interactionsRequired:
		logic()

func _input(event: InputEvent) -> void:
	if !inputEnabled and inputCallable != null:
		return
	if event.is_action("Interact_" +  str(GameManager.controlls)):
		if activeInterfaces.size() >= interactionsRequired:
			if GameManager.player == null:
				print("Player not found")
				return
				
			if collider != null:
				if collider.overlaps_body(GameManager.player):
					if inputCallableArguments != []:
						inputCallable.call(inputCallableArguments)
					else:
						inputCallable.call()
	
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
