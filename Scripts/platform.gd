extends AnimatedSprite2D

@onready var collision_shape_2d: CollisionShape2D = $StaticBody2D/CollisionShape2D

var value = false

func save():
	pass

func load():
	pass

func _ready() -> void:
	self.visible = false
	collision_shape_2d.disabled = true

func interact():
	collision_shape_2d.disabled = false
	self.visible = true
