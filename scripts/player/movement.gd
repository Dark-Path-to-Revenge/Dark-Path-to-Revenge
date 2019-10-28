func run(player):
	if !player.attacking:
		if Input.is_action_pressed("ui_left"):
			player.animated.flip_h = true
			if !player.crouched:
				player.move.x = -player.speedX
				if player.is_on_floor():
					player.animated.animation = "run"
		elif Input.is_action_pressed("ui_right"):
			player.animated.flip_h = false
			if !player.crouched:
				player.move.x = player.speedX
				if player.is_on_floor():
					player.animated.animation = "run"
		elif player.animated.animation != "idle":
			player.move.x = 0
			if player.is_on_floor() and !player.crouched:
				player.animated.animation = "idle"
				player.gravity = 10
