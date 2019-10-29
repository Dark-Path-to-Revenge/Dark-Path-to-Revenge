var is_double_jump = false

func set_jump(player, type):
	player.is_in_action = true
	player.animated.animation = type
	player.move.y = -player.jump_force
	is_double_jump = type == "salt"
	player.box_upper.set_disabled(true)
	player.box_slide.set_disabled(false)
	player.box_bottom.set_disabled(false)

func run(player):
	if Input.is_action_just_pressed("ui_jump"):
		if player.is_on_floor():
			set_jump(player, "jump")
		elif not is_double_jump:
			set_jump(player, "salt")
	elif player.is_on_floor() and player.animated.animation in ["jump", "salt"]:
		player.is_in_action = false
