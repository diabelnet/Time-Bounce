extends Control

@export var first_level := load("res://Scenes/level_1.tscn") # ustawianie do jakiego poziomu cie bierze po klikniecu play

func _on_play_pressed() -> void:
	get_tree().change_scene_to_packed(first_level)


func _on_options_pressed() -> void:
	$Settings.show()


func _on_credits_pressed() -> void:
	pass


func _on_quit_pressed() -> void:
	get_tree().quit()


func _on_settings_back() -> void:
	$Settings.hide()
	
func _ready() -> void:
	if GameManager.game_ended:
		$TextureRect.texture = load("res://Assets/BG/bg_title_color.png")
