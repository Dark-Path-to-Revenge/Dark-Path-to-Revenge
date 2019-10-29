func run(player):
	if Input.is_action_pressed("ui_down") and player.is_on_floor() and player.move.x == 0:
		player.is_in_action = true
		player.animated.animation = "crouch"
		player.box_bottom.set_disabled(true)
		player.box_upper.set_disabled(false)
		player.box_slide.set_disabled(false)
	elif player.animated.animation == "crouch":
		player.box_upper.set_disabled(true)
		player.box_bottom.set_disabled(false)
		player.box_slide.set_disabled(false)
		player.is_in_action = false
