func run(player):
	if Input.is_action_pressed("ui_down") and player.is_on_floor() and player.move.x == 0:
		player.is_in_action = true
		player.animated.animation = "crouch"
		player.body_crouch.set_disabled(true)
		player.body_normal.set_disabled(false)
		player.body_slide.set_disabled(false)
	elif player.animated.animation == "crouch":
		player.is_in_action = false
