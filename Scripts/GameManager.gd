extends Node

var controlls: int = 1
var player:CharacterBody2D

@export var time: float
@onready var delay: Timer = $Delay
@onready var timer: Timer = $Timer

var frames = 0
var recording_data = {}
var recording = false

var action:Array = [null,null]

func record():
	if(!recording):
		print("stopped")
		delay.stop()
		return
	
	recording_data[frames] = {}
	recording_data[frames][player.name] = {"position" : player.global_position}
	
	frames += 1
	
	delay.start()
	
	if(frames == 0):
		timer.start()
	
func play():
	for f in frames:
		var tween = player.create_tween()
		if(f == 0):
			player.global_position = recording_data[f][player.name]["position"]
		else:
			
			tween.tween_property(player, "global_position", recording_data[f][player.name]["position"], delay.wait_time)
		await get_tree().create_timer(delay.wait_time).timeout
		
	frames = 0
	recording_data = {}

func _on_delay_timeout() -> void:
	if(recording):
		record()


func _on_timer_timeout() -> void:
	print("a")
	recording = false
	record()
