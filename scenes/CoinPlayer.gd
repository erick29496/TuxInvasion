extends AudioStreamPlayer


func _ready():
	# Called every time the node is added to the scene.
	# Initialization here
	self.connect('finished', self, '_on_finished')
	
func _process(delta):
	if (get_playback_position() > 0.8):
		stop()

func _on_finished():
	pass
