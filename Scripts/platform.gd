extends AnimatedSprite2D

@onready var collision_shape_2d: CollisionShape2D = $StaticBody2D/CollisionShape2D
@export var usedForDoor:bool
@export var door:Node2D
var value = false

func save():
	pass

func load():
	pass
	
func reset():
	self.visible = false
	collision_shape_2d.disabled = true

func _ready() -> void:
	reset()

func interact():
	collision_shape_2d.disabled = false
	self.visible = true
	if(usedForDoor):
		door.active += 1
