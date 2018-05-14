extends Node2D

const WALK_SPEED = 300

func _ready():
	set_process(true)

func _process(delta):

	$Sprite.position.x += WALK_SPEED * delta
	$Camera.position.x += WALK_SPEED * delta