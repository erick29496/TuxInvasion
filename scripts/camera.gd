extends Camera2D

const WALK_SPEED = 300

func _ready():
	set_process(true)

func _process(delta):

	self.position.x += WALK_SPEED * delta