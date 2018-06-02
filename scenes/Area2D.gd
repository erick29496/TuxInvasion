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
			_is_collision_valid = false
			get_parent().get_parent().get_node("Characters")._addCharacter()
			_timer = Timer.new()
			add_child(_timer)
			_timer.connect("timeout", self, "_on_Timer_timeout")
			_timer.set_wait_time(0.8)
			_timer.start()
			
func _on_Timer_timeout():
	self._is_collision_valid = true