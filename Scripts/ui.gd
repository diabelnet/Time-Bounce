extends Control

var UI_element

#func start_cooldown(time:float, which: int): #time - ile czasu trwa cooldown, which - ktory cooldown wystartowac (dla ktorego UI)
	#match which:
		#1:
			#UI_element = $HBoxContainer/AbilityUI1
		#2:
			#UI_element = $HBoxContainer/AbilityUI2
		#3:
			#UI_element = $HBoxContainer/AbilityUI3
		#4:
			#UI_element = $HBoxContainer/AbilityUI4
	
	#UI_element.region *= Rect2(0,1,1,1)
	#$HBoxContainer/AbilityUI1.draw_texture_rect_region(160,0,0,0)
	#for i in 8:
		#await get_tree().create_timer(time)
		#UI_element.set_region(320,0,0,0)

#func _ready() -> void:
	#start_cooldown(8.0,1)
