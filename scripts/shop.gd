extends Panel

var points
var global

func _ready():
	global = get_tree().get_root().get_node('/root/global')
	points = global.totalPoints
	$Label10.set_text(str(points))
	pass

func _on_Button2_pressed():
	if !global.duplicateZombies && points >= 3000:
		points -= 3000
		savePoints()
		global.duplicateZombies = true
		


func _on_Button3_pressed():
	if !global.revive && points >= 1500:
		points -= 1500
		savePoints()
		global.revive = true


func _on_Button4_pressed():
	if global.startZombiesnumber != 2 && points >= 1000:
		points -= 1000
		savePoints()
		global.startZombiesnumber = 2


func _on_Button5_pressed():
	if global.startZombiesnumber != 3 && points >= 5000:
		points -= 5000
		savePoints()
		global.startZombiesnumber = 3


func _on_Button6_pressed():
	if global.startZombiesnumber != 4 && points >= 9000:
		points -= 9000
		savePoints()
		global.startZombiesnumber = 4

func savePoints():
	$Label10.set_text(str(points))
	global.totalPoints = points