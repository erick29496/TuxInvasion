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
		print("camara change")
		WALK_SPEED += 30
		futureTime = 0