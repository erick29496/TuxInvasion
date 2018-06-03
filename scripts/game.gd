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

extends Node

export(Array) var maps

const MIN_INTERVAL = 100
const MAX_INTERVAL = 250
const INITIAL_MAP_COUNT = 40

var current_max_interval
var current_min_interval

func _ready():
	_spawn_first_map()
	
func _spawn_first_map():
	pass
	#for counter in range(INITIAL_MAP_COUNT):
		#_spawn_map()
	
func _spawn_map():
	var index
	var new_map
	
	index = rand_range(0, maps.size())
	new_map = maps[index].instance()
	var pos = get_node("Camera").get_camera_position()
	#new_map.set_position(pos)
	add_child(new_map)
	

