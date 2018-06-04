extends Label

# class member variables go here, for example:
# var a = 2
# var b = "textvar"
var highscoresFile

func _ready():
	# Called every time the node is added to the scene.
	# Initialization here
	highscoresFile = File.new()
	highscoresFile.open('res://persistance/highscores.dat', highscoresFile.READ)
	var content = highscoresFile.get_as_text()
	var highscore = int(content)
	if highscore > 0:
		set_text('Highscore: ' + content)
		show()
	highscoresFile.close()

#func _process(delta):
#	# Called every frame. Delta is time since last frame.
#	# Update game logic here.
#	pass
