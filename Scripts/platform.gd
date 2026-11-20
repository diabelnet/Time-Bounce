extends Target

var node:AnimatedSprite2D
var body:StaticBody2D

func _ready() -> void:
	super()
	node = get_node(self.get_path())
	body = get_node("StaticBody2D")
	resetInteraction()

func logic():
	node.visible = true
	# enables collision with the player
	body.remove_collision_exception_with(GameManager.player)
	
func resetInteraction():
	node.visible = false
	# disables collision with the player
	body.add_collision_exception_with(GameManager.player)
