extends Control

var UI_element
var element_color

var controls = GameManager.controlls

var KeyBins

func start_cooldown(time:float, which: int): #time - ile czasu trwa cooldown, which - ktory cooldown wystartowac (dla ktorego UI)
	match which:
		1:
			UI_element = $HBoxContainer/AbilityUI1
			element_color = "R"
		2:
			UI_element = $HBoxContainer/AbilityUI2
			element_color = "G"
		3:
			UI_element = $HBoxContainer/AbilityUI3
			element_color = "B"
		4:
			UI_element = $HBoxContainer/AbilityUI4
			element_color = "P"
		
	for i in range(2,10):
		var path: String = "res://Assets/sprites/game_jam_GUI_" + element_color + "_" +str(i) + ".png"
		UI_element.texture = load(path)
		await get_tree().create_timer(time/8).timeout
	UI_element.texture = load("res://Assets/sprites/game_jam_GUI_"+ element_color+"_10.png")
		
		
func unlock(which : int):
	match which:
		1:
			$HBoxContainer/AbilityUI1.texture = load("res://Assets/sprites/game_jam_GUI_R_10.png")
			$HBoxContainer/AbilityUI1/VBoxContainer/Play.text += 
		2:
			$HBoxContainer/AbilityUI2.texture = load("res://Assets/sprites/game_jam_GUI_G_10.png")
		3:
			$HBoxContainer/AbilityUI3.texture = load("res://Assets/sprites/game_jam_GUI_B_10.png")
		4:
			$HBoxContainer/AbilityUI4.texture = load("res://Assets/sprites/game_jam_GUI_P_10.png")
