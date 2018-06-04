extends Label

# class member variables go here, for example:
# var a = 2
# var b = "textvar"
var highscoresFile

func _ready():
	# Called every time the node is added to the scene.
	# Initialization here
	var global = get_tree().get_root().get_node('/root/global')
	highscoresFile = File.new()
	var currentHighscore = _read_file(highscoresFile, 'res://persistance/highscores.dat')
	var maxHighscore = int(currentHighscore)
	var score = global.get_points()
	if score > maxHighscore:
		maxHighscore = score
		_write_file(highscoresFile, 'res://persistance/highscores.dat', str(maxHighscore))
	set_text('HIGHSCORE: ' + str(maxHighscore))

#func _process(delta):
#	# Called every frame. Delta is time since last frame.
#	# Update game logic here.
#	pass
func _read_file(file, path):
	file.open(path, file.READ)
	var content = file.get_as_text()
	file.close()
	return content
	
func _write_file(file, path, content):
	file.open(path, file.WRITE)
	file.store_string(content)
	file.close()
	return content
	