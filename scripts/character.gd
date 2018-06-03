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

extends KinematicBody2D

const GRAVITY_VEC = Vector2(0, 2500)
const FLOOR_NORMAL = Vector2(0, -1)
const SLOPE_SLIDE_STOP = 25.0
const MIN_ONAIR_TIME = 0.1
const JUMP_SPEED = 700
const MAX_JUMP = 1000
const SIDING_CHANGE_SPEED = 10
const BULLET_VELOCITY = 1000

var linear_vel = Vector2()
var onair_time = 0 #
var on_floor = false
var jump = false
var cont_jump = 0
var velocityPlus = 0
var canJump = false

var hasJumped = false

func _physics_process(delta):
	
	# check if on camera
	var pos = self.position
	var pos_dif = get_parent().get_parent().get_node('Camera').position - pos
	if pos_dif.y < -500 or pos_dif.x < -800 or pos_dif.x > 800:
		get_parent()._removeCharacter(self)
	
	#increment counters

	onair_time += delta

	### MOVEMENT ###

	# Apply Gravity
	linear_vel += delta * GRAVITY_VEC
	# Move and Slide
	linear_vel = move_and_slide(linear_vel, FLOOR_NORMAL, SLOPE_SLIDE_STOP)
	# Detect Floor
	if is_on_floor():
		onair_time = 0

	on_floor = onair_time < MIN_ONAIR_TIME

	### CONTROL ###

	# Horizontal Movement
	var target_speed =  1
		
	if target_speed == 0 or !on_floor:
		$Sprite.stop()
		if !on_floor:
			$Sprite.frame = 3
		else :
			$Sprite.frame = 1
	else:
		$Sprite.play()

	var walk_speed = 300
	if (get_parent() != null):
	 	walk_speed = get_parent().get_parent().get_node('Camera').getSpeed() + velocityPlus
	target_speed *= walk_speed
	linear_vel.x = lerp(linear_vel.x, target_speed, 0.1)
	
	# Jumping
	#if on_floor and Input.is_action_just_pressed("jump"):
	#	linear_vel.y = -JUMP_SPEED
	if on_floor and Input.is_action_pressed("jump"):
		jump = true
		
	if jump && canJump:   
		cont_jump += JUMP_SPEED
		linear_vel.y = -cont_jump
		if on_floor and Input.is_action_pressed("jump"):
			if cont_jump < MAX_JUMP:
				JUMP_SPEED = 50
			else:
				jump = false
				canJump = false
				JUMP_SPEED = 700
				cont_jump = 0
		else:
			jump = false
			canJump = false
			JUMP_SPEED = 700
			cont_jump = 0
	pass
	
func getVelocityPlus():
	return velocityPlus
	
func setVelocityPlus(var aux):
	velocityPlus = aux
	
func getJump():
	return jump
	
func setCanJump(var aux):
	canJump = aux

func _on_Area2D_body_entered(body):
	pass


func _on_Bomb_body_entered(body):
	pass
