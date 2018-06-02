extends Node2D

var start = false
var cont = 0
var total_converted = -1

func _ready():
	_addCharacter()
	start = true
	
	var bombs = get_parent().get_node('Bombs').get_children()
	for bomb in bombs:
		bomb.connect('remove_character', self, '_removeCharacter')

func _process(delta):
	if (cont == 0):
		var global = get_tree().get_root().get_node('/root/global')
		var final_points = int(get_parent().get_node('Camera/PointsLabel').get_text())
		global.set_points(final_points)
		global.set_converted(total_converted)
		get_tree().change_scene('scenes/DeathScreen.tscn')

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
	total_converted += 1
	get_parent().get_node('Camera/ZombiesLabel').set_text(str(cont))
	
func _removeCharacter(node):
	remove_child(node)
	cont -= 1
	get_parent().get_node('Camera/ZombiesLabel').set_text(str(cont))
	
func _remove_last_character():
	var last = get_children()[get_child_count() -1]
	self._removeCharacter(last)