extends Control

@onready var UI_element = [$HBoxContainer/AbilityUI1, $HBoxContainer/AbilityUI2, $HBoxContainer/AbilityUI3, $HBoxContainer/AbilityUI4]
var element_color = ["R","G","B","P"]
var KeyBins := []
@onready var YesNoElement = [$HBoxContainer/AbilityUI1/MarginContainer/VBoxContainer/HBoxContainer/YesNo, $HBoxContainer/AbilityUI2/MarginContainer/VBoxContainer/HBoxContainer/YesNo, $HBoxContainer/AbilityUI3/MarginContainer/VBoxContainer/HBoxContainer/YesNo, $HBoxContainer/AbilityUI4/MarginContainer/VBoxContainer/HBoxContainer/YesNo]
var NowActiveElement

func start_cooldown(time:float, which: int): #time - ile czasu trwa cooldown, which - ktory cooldown wystartowac (dla ktorego UI)
	var index = which
		
	for i in range(2,10):
		var path: String = "res://Assets/sprites/game_jam_GUI_" + element_color[index] + "_" +str(i) + ".png"
		UI_element[index].texture = load(path)
		await get_tree().create_timer(time/8).timeout
	UI_element[index].texture = load("res://Assets/sprites/game_jam_GUI_"+ element_color[index]+"_10.png")
				
func unlock(which : int):
	match which:
		1:
			$HBoxContainer/AbilityUI1.texture = load("res://Assets/sprites/game_jam_GUI_R_10.png")
			$HBoxContainer/AbilityUI1/MarginContainer.show()
			$HBoxContainer/AbilityUI1/MarginContainer2.show()
		2:
			$HBoxContainer/AbilityUI2.texture = load("res://Assets/sprites/game_jam_GUI_G_10.png")
			$HBoxContainer/AbilityUI2/MarginContainer.show()
			$HBoxContainer/AbilityUI2/MarginContainer2.show()
		3:
			$HBoxContainer/AbilityUI3.texture = load("res://Assets/sprites/game_jam_GUI_B_10.png")
			$HBoxContainer/AbilityUI3/MarginContainer.show()
			$HBoxContainer/AbilityUI3/MarginContainer2.show()
		4:
			$HBoxContainer/AbilityUI4.texture = load("res://Assets/sprites/game_jam_GUI_P_10.png")
			$HBoxContainer/AbilityUI4/MarginContainer.show()
			$HBoxContainer/AbilityUI4/MarginContainer2.show()

func controls_assign():
	match GameManager.controlls:
		1:
			KeyBins = ['E','Q']
		2:
			KeyBins = ['X', 'C']
	
	$HBoxContainer/AbilityUI1/MarginContainer/VBoxContainer/Play.text = "Play: " + KeyBins[0]
	$HBoxContainer/AbilityUI2/MarginContainer/VBoxContainer/Play.text = "Play: " + KeyBins[0]
	$HBoxContainer/AbilityUI3/MarginContainer/VBoxContainer/Play.text = "Play: " + KeyBins[0]
	$HBoxContainer/AbilityUI4/MarginContainer/VBoxContainer/Play.text = "Play: " + KeyBins[0]
	
	$HBoxContainer/AbilityUI1/MarginContainer/VBoxContainer/Record.text = "Play: " + KeyBins[1]
	$HBoxContainer/AbilityUI2/MarginContainer/VBoxContainer/Record.text = "Play: " + KeyBins[1]
	$HBoxContainer/AbilityUI3/MarginContainer/VBoxContainer/Record.text = "Play: " + KeyBins[1]
	$HBoxContainer/AbilityUI4/MarginContainer/VBoxContainer/Record.text = "Play: " + KeyBins[1]
			
func change_recorded_save(which:int, is_there:bool):
	if is_there:
		YesNoElement[which].texture = load("res://Assets/sprites/Yes.png")
	else:
		YesNoElement[which].texture = load("res://Assets/sprites/No.png")
	
func now_active(which:int):
	$HBoxContainer/AbilityUI1/MarginContainer2/IsNowActive.hide()
	$HBoxContainer/AbilityUI2/MarginContainer2/IsNowActive.hide()
	$HBoxContainer/AbilityUI3/MarginContainer2/IsNowActive.hide()
	$HBoxContainer/AbilityUI4/MarginContainer2/IsNowActive.hide()
	match which:
		1:
			$HBoxContainer/AbilityUI1/MarginContainer2/IsNowActive.show()
		2:
			$HBoxContainer/AbilityUI2/MarginContainer2/IsNowActive.show()
		3:
			$HBoxContainer/AbilityUI3/MarginContainer2/IsNowActive.show()
		4:
			$HBoxContainer/AbilityUI4/MarginContainer2/IsNowActive.show()

	
