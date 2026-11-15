extends AnimatedSprite2D

@onready var collision_shape_2d: CollisionShape2D = $StaticBody2D/CollisionShape2D
@export var usedForDoor:bool
@export var door:Node2D
var count = 0
@export var needs:int

func save():
	pass

func load():
	reset()
	
func reset():
	if(count < needs):
		self.visible = true
		collision_shape_2d.disabled = false

func _ready() -> void:
	reset()

func interact():
	count += 1
	if(count >= needs):
		collision_shape_2d.disabled = true
		self.visible = false
		if(usedForDoor):
			door.active += 1
