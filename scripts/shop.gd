extends Panel

var PATH = 'res://persistance/user.dat'
var points
var duplicateZombies
var revive
var startZombiesNumber
var data = null
var file = File.new()

func _ready():
	var content = _read_file(file, PATH)
	if content.length() > 0:
		data = content.split(',')
	else:
		data = ['0', 'false', 'false', '1']
		_write_file(file, PATH, arr_join(data, ','))
	points = int(data[0])
	duplicateZombies = data[1].to_lower() == 'true'
	revive = data[2].to_lower() == 'true'
	startZombiesNumber = int(data[3])
	$Label10.set_text(str(points))
	pass

func _on_Button2_pressed():
	if !duplicateZombies && points >= 3000:
		points -= 3000
		savePoints()
		duplicateZombies = true
		data[0] = str(points)
		data[1] = str(duplicateZombies)
		_write_file(file, PATH, arr_join(data, ','))

func _on_Button3_pressed():
	if !revive && points >= 1500:
		points -= 1500
		savePoints()
		revive = true
		data[0] = str(points)
		data[2] = str(revive)
		_write_file(file, PATH, arr_join(data, ','))

func _on_Button4_pressed():
	if startZombiesNumber != 2 && points >= 1000:
		points -= 1000
		savePoints()
		startZombiesNumber = 2
		data[0] = str(points)
		data[3] = str(startZombiesNumber)
		_write_file(file, PATH, arr_join(data, ','))

func _on_Button5_pressed():
	if startZombiesNumber != 3 && points >= 5000:
		points -= 5000
		savePoints()
		startZombiesNumber = 3
		data[0] = str(points)
		data[3] = str(startZombiesNumber)
		_write_file(file, PATH, arr_join(data, ','))

func _on_Button6_pressed():
	if startZombiesNumber != 4 && points >= 9000:
		points -= 9000
		savePoints()
		startZombiesNumber = 4
		data[0] = str(points)
		data[3] = str(startZombiesNumber)
		_write_file(file, PATH, arr_join(data, ','))

func savePoints():
	$Label10.set_text(str(points))
	
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
	
func arr_join(arr, separator = ""):
    var output = "";
    for s in arr:
        output += str(s) + separator
    output = output.left( output.length() - separator.length() )
    return output