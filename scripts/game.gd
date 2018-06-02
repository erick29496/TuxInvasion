extends Node

# class member variables go here, for example:
# var a = 2
# var b = "textvar"

func _ready():
	# Called every time the node is added to the scene.
	# Initialization here
	get_node('Characters').connect("score_changed", self, "on_score_changed")
	
func on_score_changed():
	print('score changed')
	get_node('RichTextLabel').set_text('100')

#func _process(delta):
#	# Called every frame. Delta is time since last frame.
#	# Update game logic here.
#	pass


