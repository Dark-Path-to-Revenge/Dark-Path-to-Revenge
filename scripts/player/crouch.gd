func run(player):
	if Input.is_action_pressed("ui_down") and player.is_on_floor() and !player.attacking and player.move.x == 0:
		player.animated.animation = "duck"
		player.box_bottom.set_disabled(true)
		player.box_upper.set_disabled(false)
		player.crouched = true
	elif player.animated.animation == "duck":
		player.box_upper.set_disabled(true)
		player.box_bottom.set_disabled(false)
		player.crouched = false
