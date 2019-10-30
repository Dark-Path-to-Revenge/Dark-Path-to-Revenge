var jump_count = 0

func run(player):
	if Input.is_action_just_pressed("ui_jump") and jump_count < player.jump_quantity:
		player.is_in_action = true
		jump_count += 1
		player.animated.animation = "salt" if jump_count > 1 else "jump"
		player.move.y = -player.jump_force * player.delta
		player.body_normal.set_disabled(true)
		player.body_slide.set_disabled(false)
		player.body_crouch.set_disabled(false)
	elif player.is_on_floor():
		jump_count = 0
		if player.animated.animation in ["jump", "salt"]:
			player.is_in_action = false
