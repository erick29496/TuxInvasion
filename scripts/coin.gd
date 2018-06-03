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

extends Area2D


func _on_Coin_body_entered(body):
	get_parent().get_parent().get_node('CanvasLayer/PointsLabel')._add_points(50)
	get_parent().get_parent().get_node('CoinPlayer').play()
	$Anim.play("collect")
	$Shape.queue_free()
	yield(get_node("Anim"), "animation_finished")
	queue_free()
