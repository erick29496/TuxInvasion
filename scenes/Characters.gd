extends Node2D

signal new_character
signal score_changed(score)

# class member variables go here, for example:
# var a = 2
# var b = "textvar"

func _ready():
	_addCharacter()
	self.connect('new_character', self, '_addCharacter')

#func _process(delta):
#	# Called every frame. Delta is time since last frame.
#	# Update game logic here.
#	pass

func _addCharacter():
	var scene = load("res://scenes/Character.tscn")
	var scene_instance = scene.instance()
	var pos = get_parent().get_node("Camera").get_camera_position()
	scene_instance.set_name("CharacterX")
	scene_instance.set_position(pos)
	add_child(scene_instance)
	emit_signal('score_changed', 100)
	print("Added new character")
	
func _removeCharacter(node):
	print('Removing character')
	remove_child(node)