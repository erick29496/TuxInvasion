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
	timer.set_wait_time(1)
	timer.start()
	
func _on_timer_timeout():
	if get_parent().get_node("Camera").WALK_SPEED >= 400:
		_spawn_object()
	
func _spawn_object():
	var index
	var new_object
	index = 1#randi()%objects.size()
	new_object = objects[index].instance()
	var pos = get_parent().get_node("Camera").get_camera_position() + Vector2(700, 0)
	if (index == 0):
		pos.y = 600
	elif index == 2:
		if get_parent().get_node("Characters").get_children()[0].onair_time == 0:
			pos.y = get_parent().get_node("Characters").get_children()[0].position.y
		else:
			index = 1
			new_object = objects[index].instance()
	elif (index == 3):
		pos.y = 200
	if (index == 1):
		pos.y = randi()%200+200
	new_object.set_position(pos)
	add_child(new_object)
	if (randi()%4 == 0):
		new_object = objects[index].instance()
		pos += Vector2(130, 0)
		new_object.set_position(pos)
		add_child(new_object)
		if (randi()%2 == 0):
			if index == 0:
				if get_parent().get_node("Camera").WALK_SPEED >= 900:
					new_object = objects[index].instance()
					new_object.set_position(pos + Vector2(130, 0))
					add_child(new_object)
			else:
				new_object = objects[index].instance()
				new_object.set_position(pos + Vector2(130, 0))
				add_child(new_object)

