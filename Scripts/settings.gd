extends Control

signal back

func _on_back_pressed() -> void:
	back.emit()


func _on_win_set_focus_exited() -> void:
	if $ColorRect/MarginContainer/VBoxContainer/HBoxContainer2/WinSet.selected == 0:
		#DisplayServer.WINDOW_MODE_WINDOWED 
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_WINDOWED)
	else:
		#DisplayServer.WINDOW_MODE_FULLSCREEN
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_FULLSCREEN)


func _on_movment_option_focus_exited() -> void:
	GameManager.controlls = $ColorRect/MarginContainer/VBoxContainer/HBoxContainer/MovmentOption.selected
	print(GameManager.controlls)
