func run(player):
	if Input.is_action_pressed("ui_left"):
		player.animated.flip_h = true
		player.move.x = -player.moviment_speed * player.delta
		if not player.is_in_action:
			player.animated.animation = "moviment"
	elif Input.is_action_pressed("ui_right"):
		player.animated.flip_h = false
		player.move.x = player.moviment_speed * player.delta
		if not player.is_in_action:
			player.animated.animation = "moviment"
	elif player.animated.animation != "idle":
		player.move.x = 0
		if not player.is_in_action:
			player.animated.animation = "idle"
			player.body_normal.set_disabled(true)
			player.body_crouch.set_disabled(false)
			player.body_slide.set_disabled(false)
