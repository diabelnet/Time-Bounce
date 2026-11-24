extends Target

var node:AnimatedSprite2D
var body:StaticBody2D

@export var inverted := false;

func _ready() -> void:
	super()
	node = get_node(self.get_path())
	body = get_node("StaticBody2D")
	resetInteraction()

func logic():
	node.visible = !inverted
	# enables collision with the player
	if(!inverted):
		body.remove_collision_exception_with(GameManager.player)
	else:
			body.add_collision_exception_with(GameManager.player)
	
func resetInteraction():
	node.visible = inverted
	# disables collision with the player
	if(inverted):
		body.remove_collision_exception_with(GameManager.player)
	else:
			body.add_collision_exception_with(GameManager.player)
