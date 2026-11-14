extends Control

@export var first_level := load("res://Scenes/level_1.tscn") # ustawianie do jakiego poziomu cie bierze po klikniecu play

func _on_play_pressed() -> void:
	get_tree().change_scene_to_packed(first_level)


func _on_options_pressed() -> void:
	pass # Replace with function body.


func _on_credits_pressed() -> void:
	pass # Replace with function body.


func _on_quit_pressed() -> void:
	get_tree().quit()
