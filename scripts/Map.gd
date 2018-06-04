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

export(Array) var maps
var timer
var getPos = false
var distance
var startCreate = false
var cont = 0
var firstMap = true

func _ready():
	getPos = true
	
func _process(delta):
	if getPos:
		distance = get_parent().get_node("Camera").get_camera_position() + Vector2(1250, 0)
		getPos = false
		startCreate = true
	if startCreate:
		if get_parent().get_node("Camera").get_camera_position() >= distance:
			_spawn_map()
			if cont == 5:
				cont = 0
				remove_child(self.get_children()[0])
			getPos = true
	
func _spawn_map():
	cont += 1
	var index
	var new_map
	if (firstMap): 
		index = 0
		firstMap = false
	else: 
		if get_parent().get_node("Camera").WALK_SPEED <= 550:
			index = randi()%3
		elif get_parent().get_node("Camera").WALK_SPEED <= 850:
			index = randi()%5
		elif get_parent().get_node("Camera").WALK_SPEED <= 1000:
			index = randi()%7
		else:
			index = randi()%maps.size()
	new_map = maps[index].instance()
	var pos = get_parent().get_node("Camera").get_camera_position() + Vector2(1000, -360)
	new_map.set_position(pos)
	add_child(new_map)
	

