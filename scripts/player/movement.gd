func flip_magic(player):
	player.shot.position.x = -1 if player.is_left else 1

func run(player):
	if Input.is_action_pressed('ui_left'):
		if not player.is_left:
			player.is_left = true
			player.scale.x = -1
		player.move.x = -player.moviment_speed * player.delta
		if not player.is_in_action:
			player.animated.animation = 'moviment'
		flip_magic(player)
	elif Input.is_action_pressed('ui_right'):
		if player.is_left:
			player.is_left = false
			player.scale.x = -1
		player.move.x = player.moviment_speed * player.delta
		if not player.is_in_action:
			player.animated.animation = 'moviment'
		flip_magic(player)
	elif player.animated.animation != 'idle':
		player.move.x = 0
		if not player.is_in_action:
			player.animated.animation = 'idle'
			player.body_normal.set_disabled(false)
			player.body_crouch.set_disabled(true)
			player.body_slide.set_disabled(true)

