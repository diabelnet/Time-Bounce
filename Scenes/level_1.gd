extends Node2D

var is_recording:=false #is now recording, active when beaing recorded
var can_record:=false #checks if it can record, turning recording off after x seconds in this script
var can_frame:=true #checks if you can save next frame, in this script after 0.1s
var is_timer_started:=false #checks if timer for can_record is started so it can turn off after
var did_return := true #check if player returned to thier first position after recording

func _process(delta: float) -> void:
	if can_record:
		if is_recording == true: #checks if button is pressed for recording or is it recording now
			did_return = false
			is_recording = true

			if !is_timer_started: #if timer isnt startet it startsit
				$RecordingTime.start()
				is_timer_started = true
				
			if can_frame: #if it can record next frame it records
				$replay.record()
				can_frame = false
				$RecordingFps.start()
				
	elif Input.is_action_just_pressed("Record_Clone_" + str(GameManager.controlls)):
			for c in get_children():
				if(c.name == "Computer"):
					c.save()
			is_recording = true
			can_record = true
			
	elif did_return == false: #when recording ends it checks if player returned, if not then it retuns them
				$replay.return_to_orginal_position()
				did_return = true
			
	if Input.is_action_just_pressed("Play_Clone_1"): #plays recording when prompted
		$replay.play(true)

func _on_recording_fps_timeout() -> void: #to musi byc ustawione na One Shot
	can_frame = true

func _on_recording_time_timeout() -> void: #to tez musi byc ustawione na one shot
	can_record = false
	is_timer_started = false
	
	for c in get_children():
				if(c.name == "Computer"):
					c.save()
