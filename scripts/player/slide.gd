var count_duration = 0

func run(player):
	if (Input.is_action_pressed('ui_slide') and count_duration < player.slide_duration):
		if player.is_on_floor():
			player.is_in_action = true
			count_duration += player.delta * 100
			player.body_slide.set_disabled(false)
			player.body_normal.set_disabled(true)
			player.body_crouch.set_disabled(true)
			player.animated.animation = 'slide'
			player.move.x = -player.slide_speed if player.is_left else player.slide_speed
			player.move.x *= player.delta
	elif Input.is_action_just_released('ui_slide'):
		count_duration = 0
	elif player.animated.animation == 'slide':
		player.is_in_action = false
