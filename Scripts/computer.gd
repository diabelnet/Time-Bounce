extends Interface

var sprite:AnimatedSprite2D
@export var flickerCount:int

func _ready() -> void:
	super()
	sprite = get_node("Sprite")

func reset():
	sprite.play("def")

func interact():
	sprite.play("flicker")
	
	for i in range(0, flickerCount):
		sprite.play("flicker")
		await sprite.animation_finished
		
	sprite.play("anim")
