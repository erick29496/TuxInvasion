extends Node2D

signal new_character
signal score_changed(score)
var start = false
var cont = 0

func _ready():
	_addCharacter()
	start = true
	self.connect('new_character', self, '_addCharacter')

func _process(delta):
	if (cont == 0):
		get_tree().quit()

func _addCharacter():
	var scene = load("res://scenes/Character.tscn")
	var scene_instance = scene.instance()
	var pos = get_parent().get_node("Camera").get_camera_position()
	if (start): 
		var aux = randi()%600-200
		pos -= Vector2(aux, 70)
	print(pos)
	scene_instance.set_name("CharacterX")
	scene_instance.set_position(pos)
	add_child(scene_instance)
	emit_signal('score_changed', 100)
	cont += 1;
	print("Added new character")
	
func _removeCharacter(node):
	print('Removing character')
	remove_child(node)
	cont -= 1