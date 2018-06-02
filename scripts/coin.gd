extends Area2D


func _on_Coin_body_entered(body):
	get_parent().get_parent().get_node('Camera/PointsLabel')._add_points(50)
	$Anim.play("collect")
	$Shape.queue_free()
	yield(get_node("Anim"), "animation_finished")
	queue_free()
