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

export(Array) var objects
var timer

func _ready():
	timer = Timer.new()
	timer.connect("timeout",self,"_on_timer_timeout")
	add_child(timer)
	timer.set_wait_time(2)
	timer.start()
	
func _on_timer_timeout():
	_spawn_object()
	
func _spawn_object():
	var index
	var new_object
	index = randi()%objects.size()
	new_object = objects[index].instance()
	var pos = get_parent().get_node("Camera").get_camera_position() + Vector2(700, 0)
	new_object.set_position(pos)
	add_child(new_object)
	

