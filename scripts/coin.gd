extends Area2D


func _on_Coin_body_entered(body):
	$Anim.play("collect")
	$Shape.queue_free()
	yield(get_node("Anim"), "animation_finished")
	queue_free()
