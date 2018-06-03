# TUX INVASION: a zombie mobile video game
# Copyright (C) 2018 Roger Oriol Pérez, Èric Rodríguez Balsells, Laura Figuerola Peña
#
# This program is free software: you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation, either version 3 of the License, or
# (at your option) any later version.
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with this program.  If not, see <http://www.gnu.org/licenses/>.

extends Node2D

var start = false
var cont = 0
var total_converted = -1
var jump = false
var startJump = false
var contJump = 0
var firstZombie
var firstZombiePosition = null

var startZombiesx2 = false
var startZombiesx3 = false
var startZombiesx4 = false

var revive = false
var peopleGroup = false
var duplicateZombies = false


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
		
	if (self.get_children().size() > 0 && self.get_children()[0].getJump()):
		jump = true
		firstZombie = self.get_children()[0]
		if firstZombiePosition == null:
			firstZombiePosition = self.get_children()[0].position
		
	var index = 0
	while (index < self.get_children().size()):
		var i = self.get_children()[index]
		var currentPosition = get_parent().get_node("Camera").get_camera_position().x - i.position.x
		if jump:
			if (i.position < firstZombiePosition):
				firstZombiePosition = i.position
				firstZombie = i
		if startJump:
			if (i.position <= firstZombiePosition):
				i.setCanJump(true)
				contJump += 1
		if currentPosition > 300:
			i.setVelocityPlus(100)
		else:
			if (i.getVelocityPlus() != 0):
				i.setVelocityPlus(0)
		index += 1
		
	if jump:
		startJump = true
		firstZombie.setCanJump(true)
		contJump += 1
		jump = false
		
	if contJump == self.get_children().size():
		startJump = false
		contJump = 0
		firstZombiePosition = null
		
	
			
func _addCharacter():
	var rnd = randi()%3
	var scene
	match rnd:
		0: scene = load("res://scenes/Character.tscn")
		1: scene = load("res://scenes/Character2.tscn")
		2: scene = load("res://scenes/Character3.tscn")
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
	
func getCharacters():
	return self.get_children()
	
	
