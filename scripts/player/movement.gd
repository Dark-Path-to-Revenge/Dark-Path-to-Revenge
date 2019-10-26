extends KinematicBody2D

func run(node, onfloor):
	#anda para esquerda ou para direita ou fica parado
	if Input.is_action_pressed("ui_left"):
		node.flip_h = true
		if !Global.crouch:
			Global.move.x = -Global.speedX
			if onfloor:
				node.animation = "run"
	elif Input.is_action_pressed("ui_right"):
		node.flip_h = false
		if !Global.crouch:
			Global.move.x = Global.speedX
			if onfloor:
				node.animation = "run"
	else:
		Global.move.x = 0
		if onfloor and !Global.crouch:
			node.animation = "idle"
			node.get_sprite_frames().set_animation_speed("idle", 5.0)
			Global.gravity = 10