extends Node2D

#var is_recording:=false #is now recording, active when beaing recorded
var can_record:=false #checks if it can record, turning recording off after x seconds in this script
var can_frame:=true #checks if you can save next frame, in this script after 0.1s
var is_timer_started:=false #checks if timer for can_record is started so it can turn off after
var did_return := true #check if player returned to thier first position after recording
var is_playing_replay_rn := false

var can_click := false	
var clone_inputed := false

var is_in_door := false
var door_open :=false

@onready var replay1 = $replay
@onready var replay2 = $replay2

func _ready() -> void:
	get_tree().call_group('UI', 'unlock', 2)

func _process(delta: float) -> void:
	if can_record:
		if GameManager.is_recording == true: #checks if button is pressed for recording or is it recording now
			did_return = false
			GameManager.is_recording = true

			if !is_timer_started: #if timer isnt startet it startsit
				$RecordingTime.start()
				is_timer_started = true
				
			if can_frame: #if it can record next frame it records
				match GameManager.curr_clone:
					0:
						$replay.record()
					1:
						$replay2.record()
				can_frame = false
				$RecordingFPS.start()
				
	elif Input.is_action_just_pressed("Record_Clone_" + str(GameManager.controlls)) and !is_playing_replay_rn:
		get_tree().call_group('UI', 'start_cooldown', 3,GameManager.curr_clone)
		
		GameManager.is_recording = true
		can_record = true
		$replay.reset()
			
	elif did_return == false: #when recording ends it checks if player returned, if not then it retuns them
				$replay.return_to_orginal_position()
				did_return = true
				door_open = false
			
	if Input.is_action_just_pressed("Play_Clone_"+str(GameManager.controlls)) and !is_playing_replay_rn and $replay.is_recorded() and !GameManager.is_recording: #plays recording when prompted
		is_playing_replay_rn = true
		get_tree().call_group('UI', 'start_cooldown', 3,GameManager.curr_clone)
		$replay.play(true)
		await get_tree().create_timer(3).timeout
		is_playing_replay_rn = false

	if can_click:
		print("can click")
		if Input.is_action_just_pressed("Interact_1") or clone_inputed:
			door_open = true
			print("door opened")
	
	if is_in_door and door_open:
		if Input.is_action_just_pressed("Interact_1"):
			get_tree().change_scene_to_file("res://Scenes/level_3.tscn")
			
			
func _input(event: InputEvent) -> void:
	if Input.is_action_just_pressed("Clone_1_1") and !can_record:
		GameManager.curr_clone = 0
		get_tree().call_group('UI', 'now_active', 1)
	elif Input.is_action_just_pressed("Clone_2_1") and !can_record:
		GameManager.curr_clone = 1
		get_tree().call_group('UI', 'now_active', 2)


func _on_recording_time_timeout() -> void:
	can_frame = true


func _on_recording_fps_timeout() -> void:
	can_record = false
	is_timer_started = false
	GameManager.is_recording = false
	get_tree().call_group('UI', 'change_recorded_save', GameManager.curr_clone, true)
