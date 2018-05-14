extends KinematicBody2D

const GRAVITY_VEC = Vector2(0, 1100)
const FLOOR_NORMAL = Vector2(0, -1)
const SLOPE_SLIDE_STOP = 25.0
const MIN_ONAIR_TIME = 0.1
const WALK_SPEED = 300 # pixels/sec
const JUMP_SPEED = 300
const MAX_JUMP = 700
const SIDING_CHANGE_SPEED = 10
const BULLET_VELOCITY = 1000

var linear_vel = Vector2()
var onair_time = 0 #
var on_floor = false
var jump = false
var cont_jump = 0

func _physics_process(delta):
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

	target_speed *= WALK_SPEED
	linear_vel.x = lerp(linear_vel.x, target_speed, 0.1)

	# Jumping
	#if on_floor and Input.is_action_just_pressed("jump"):
	#	linear_vel.y = -JUMP_SPEED
	if on_floor and Input.is_action_pressed("jump"):
		jump = true
		
	if jump:   
		if Input.is_action_pressed("jump"):
			cont_jump += JUMP_SPEED
			linear_vel.y = -cont_jump
			if cont_jump < MAX_JUMP:
				JUMP_SPEED = 50
			else:
				jump = false
				JUMP_SPEED = 300
				cont_jump = 0
		else:
			jump = false
			JUMP_SPEED = 300
			cont_jump = 0
	pass

func _on_Area2D_body_entered(body):
	pass


func _on_Bomb_body_entered(body):
	pass