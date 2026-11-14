extends Node2D

var is_recording:=false
var can_record:=true
var can_frame:=true
var is_timer_started:=false


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if can_record:
		if Input.is_action_just_pressed("Record_Clone_1") or is_recording == true:
			print("recording")
			is_recording = true
			if can_record == false:
				is_recording = false
			if !is_timer_started:
				$record_time.start()
				is_timer_started = true	
			if can_frame:
				$replay.record()
				can_frame = false
				$record.start()
			
	if Input.is_action_just_pressed("Play_Clone_1"):
		$replay.play(true)


func _on_record_timeout() -> void:
	print("frame")
	can_frame = true


func _on_record_time_timeout() -> void:
	print("ending rec")
	can_record = false
	is_timer_started = false
