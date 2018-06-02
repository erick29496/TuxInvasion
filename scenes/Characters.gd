extends Node2D

var start = false
var cont = 0

func _ready():
	_addCharacter()
	start = true
	#get_parent().get_node('Bombs/Bomb').connect('remove_character', self, '_removeCharacter')
	#get_parent().get_node('Bombs/Bomb2').connect('remove_character', self, '_removeCharacter')
	#get_parent().get_node('Bombs/Bomb3').connect('remove_character', self, '_removeCharacter')
	
	var bombs = get_parent().get_node('Bombs').get_children()
	for bomb in bombs:
		bomb.connect('remove_character', self, '_removeCharacter')

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
	scene_instance.set_name("CharacterX")
	scene_instance.set_position(pos)
	add_child(scene_instance)
	cont += 1;
	get_parent().get_node('Camera/ZombiesLabel').set_text(str(cont))
	
func _removeCharacter(node):
	remove_child(node)
	cont -= 1
	get_parent().get_node('Camera/ZombiesLabel').set_text(str(cont))
	
func _remove_last_character():
	var last = get_children()[get_child_count() -1]
	self._removeCharacter(last)