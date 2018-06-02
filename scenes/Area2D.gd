extends Area2D

signal new_character

# class member variables go here, for example:
# var a = 2
# var b = "textvar"
var _timer
var _is_collision_valid = true

func _ready():
	# Called every time the node is added to the scene.
	# Initialization here
	pass

func _physics_process(delta):
	var bodies = get_overlapping_bodies()
	for body in bodies:
		if (body.name.find('Character') > -1 && self._is_collision_valid):
			get_parent().get_parent().get_node("Characters")._addCharacter()
			queue_free()
