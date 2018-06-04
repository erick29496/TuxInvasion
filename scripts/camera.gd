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

extends Camera2D

var WALK_SPEED = 300
var time = 0
var futureTime = 0

func _ready():
	set_process(true)
	
func getSpeed():
	return self.WALK_SPEED

func _process(delta):
	time += delta
	if futureTime == 0:
		futureTime = time + 5
	self.position.x += WALK_SPEED * delta
	if time >= futureTime:
		WALK_SPEED += 50
		futureTime = 0
		print (WALK_SPEED)
