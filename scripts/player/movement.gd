var is_left = false

func run(player):
	if Input.is_action_pressed('ui_left'):
		if not is_left:
			is_left = true
			player.scale.x = -1
		player.move.x = -player.moviment_speed * player.delta
		if not player.is_in_action:
			player.animated.animation = 'moviment'
	elif Input.is_action_pressed('ui_right'):
		if is_left:
			is_left = false
			player.scale.x = -1
		player.move.x = player.moviment_speed * player.delta
		if not player.is_in_action:
			player.animated.animation = 'moviment'
	elif player.animated.animation != 'idle':
		player.move.x = 0
		if not player.is_in_action:
			player.animated.animation = 'idle'
			player.body_normal.set_disabled(false)
			player.body_crouch.set_disabled(true)
			player.body_slide.set_disabled(true)
