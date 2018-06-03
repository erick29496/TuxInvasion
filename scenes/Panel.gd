extends Panel

# class member variables go here, for example:
# var a = 2
# var b = "textvar"

func _ready():
	# Called every time the node is added to the scene.
	# Initialization here
	get_stylebox("panel", "" ).set_texture(load("res://assets/img/halloween-background-with-zombie-hand-bursting-out-of-the-ground_1048-6914.jpg"))

#func _process(delta):
#	# Called every frame. Delta is time since last frame.
#	# Update game logic here.
#	pass
