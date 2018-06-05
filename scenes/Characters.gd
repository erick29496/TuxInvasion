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

var cont = 0
var total_converted = -1
var jump = false
var startJump = false
var contJump = 0
var firstZombie
var firstZombiePosition
var firstZombieIndex
var totalPoints
var startZombiesnumber = 1

var revive = false
var duplicateZombies = false


func _ready():
	var userData = _read_user_data()
	totalPoints = userData[0]
	startZombiesnumber = int(userData[3])
	revive = userData[2].to_lower() == 'true'
	duplicateZombies = userData[1].to_lower() == 'true'
	var contAux  = 0
	if (duplicateZombies):
		duplicateZombies = false
		_save_user_data()
		startZombiesnumber *= 2
	while (contAux < startZombiesnumber):
		_addCharacter()
		contAux += 1
	var bombs = get_parent().get_node('Bombs').get_children()
	for bomb in bombs:
		bomb.connect('remove_character', self, 'explosion')

func _process(delta):
	if (cont == 0):
		if revive:
			_addCharacter()
			revive = false
			_save_user_data()
		else:
			var global = get_tree().get_root().get_node('/root/global')
			var final_points = int(get_parent().get_node('CanvasLayer/PointsLabel').get_text())
			global.set_points(final_points)
			totalPoints = str(int(totalPoints) + final_points)
			_save_user_data()
			global.totalPoints = int(totalPoints)
			global.set_converted(total_converted)
			get_tree().change_scene('scenes/DeathScreen.tscn')
		
	if (self.get_children().size() > 0 && self.get_children()[0].getJump() && !startJump):
		jump = true
		firstZombie = self.get_children()[0]
		firstZombiePosition = self.get_children()[0].position
		firstZombieIndex = 0
		
	var index = 0
	var allZombiesJumped = true
	while (index < self.get_children().size()):
		var i = self.get_children()[index]
		var currentPosition = get_parent().get_node("Camera").get_camera_position().x - i.position.x
		if jump:
			if (i.position >= firstZombiePosition):
				firstZombiePosition = i.position
				firstZombie = i
				firstZombieIndex = index
			i.hasJumped = false
		if startJump:
			if (!i.hasJumped):
				allZombiesJumped = false
				if (i.position >= firstZombiePosition):
					i.setCanJump(true)
					i.hasJumped = true
					contJump += 1
		if currentPosition > 300:
			i.setVelocityPlus(100)
		else:
			if (i.getVelocityPlus() != 0):
				i.setVelocityPlus(0)
		index += 1
		
	if (startJump && allZombiesJumped):
		startJump = false
		
	if jump:
		startJump = true
		firstZombie.setCanJump(true)
		contJump += 1
		self.get_children()[firstZombieIndex].hasJumped = true
		jump = false
			
func _addCharacter():
	var rnd = randi()%3
	var scene
	match rnd:
		0: scene = load("res://scenes/Character.tscn")
		1: scene = load("res://scenes/Character2.tscn")
		2: scene = load("res://scenes/Character3.tscn")
	var scene_instance = scene.instance()
	var pos = get_parent().get_node("Camera").get_camera_position()
	var aux = randi()%300-100
	pos -= Vector2(aux, 70)
	scene_instance.set_name("CharacterX")
	scene_instance.set_position(pos)
	add_child(scene_instance)
	cont += 1;
	total_converted += 1
	get_parent().get_node('CanvasLayer/ZombiesLabel').set_text(str(cont))
	
func explosion(node):
	get_parent().get_node('BombPlayer').play()
	_removeCharacter(node)

func _removeCharacter(node):
	remove_child(node)
	cont -= 1
	get_parent().get_node('CanvasLayer/ZombiesLabel').set_text(str(cont))
	
func _remove_last_character():
	var last = get_children()[get_child_count() -1]
	self._removeCharacter(last)
	
func getCharacters():
	return self.get_children()
	
func _read_user_data():
	var file = File.new()
	file.open('res://persistance/user.dat', file.READ)
	var content = file.get_as_text()
	file.close()
	var result = ['0','false','false','1']
	if content.length() > 0:
		return content.split(',')
	else:
		return result

func _save_user_data():
	var file = File.new()
	file.open('res://persistance/user.dat', file.WRITE)
	var content = totalPoints+','+str(duplicateZombies)+','+str(revive)+','+str(startZombiesnumber)
	file.store_string(content)
	file.close()
	return content