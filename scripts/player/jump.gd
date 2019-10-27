var is_double_jump = false

func set_jump(player, type):
	player.animated.animation = type
	player.move.y = player.jumpforce
	is_double_jump = type == "salt"

func run(player):
	if Input.is_action_just_pressed("ui_jump") and !player.sliding and !player.crouched:
		if player.is_on_floor():
			set_jump(player, "jump")
		elif not is_double_jump:
			set_jump(player, "salt")
