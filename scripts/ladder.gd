extends Area2D

func _on_Area2D_body_entered(body):
	if body.is_in_group("player"):
		var flag = get_node("../player")
		flag.climb_ladder = true
		flag.gravity = 0

func _on_Area2D_body_exited(body):
	if body.is_in_group("player"):
		var flag = get_node("../player")
		flag.climb_ladder = false
		flag.gravity = 10
		flag.climb_fall = true