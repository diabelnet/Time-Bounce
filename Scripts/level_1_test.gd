extends Node2D

var is_recording:=false #is now recording, active when beaing recorded
var can_record:=true #checks if it can record, turning recording off after x seconds in this script
var can_frame:=true #checks if you can save next frame, in this script after 0.1s
var is_timer_started:=false #checks if timer for can_record is started so it can turn off after
var did_return := true #check if player returned to thier first position after recording


func _process(delta: float) -> void:
	if can_record:
		if Input.is_action_just_pressed("Record_Clone_1") or is_recording == true: #checks if button is pressed for recording or is it recording now
			did_return = false
			print("recording")
			is_recording = true
			
			if !is_timer_started: #if timer isnt startet it startsit
				$record_time.start()
				is_timer_started = true
				
			if can_frame: #if it can record next frame it records
				$replay.record()
				can_frame = false
				$record.start()
				
	elif did_return == false: #when recording ends it checks if player returned, if not then it retuns them
				print("cos")
				$replay.return_to_orginal_position()
				did_return = true
			
	if Input.is_action_just_pressed("Play_Clone_1"): #plays recording when prompted
		$replay.play(true)




func _on_replay_player_input() -> void: #signal from replay node, activates when input was recorded
	print("inputed")


func _on_record_time_timeout() -> void: #after time out turns recording off
	print("ending rec")
	can_record = false
	is_timer_started = false
	


func _on_record_timeout() -> void: #if activates, recording can record next frame
	print("frame")
	can_frame = true
