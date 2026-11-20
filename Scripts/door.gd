extends Target

var sprite:AnimatedSprite2D
var node:Node

func _ready() -> void:
	super() # <- get methodes from the base class
	sprite = self.find_child("Sprite")
	inputCallable = GameManager.next_level

func logic():
	sprite.play("open")

func resetInteraction():
	sprite.play("def")
