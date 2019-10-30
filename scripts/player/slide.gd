var count_duration = 0

func run(player):
	if (Input.is_action_pressed("ui_slide")
			and player.is_on_floor() and count_duration < player.slide_duration):
		player.is_in_action = true
		count_duration += player.delta * 100
		player.body_slide.set_disabled(true)
		player.body_normal.set_disabled(false)
		player.body_crouch.set_disabled(false)
		player.animated.animation = "slide"
		player.move.x = -player.slide_speed if player.animated.flip_h else player.slide_speed
		player.move.x *= player.delta
	elif Input.is_action_just_released("ui_slide"):
		count_duration = 0
	elif player.animated.animation == "slide":
		player.is_in_action = false
