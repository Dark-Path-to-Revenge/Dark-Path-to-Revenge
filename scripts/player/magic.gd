func run(player):
	if Input.is_action_just_pressed('ui_magic') and player.energy > 0:
		var hands
		player.magic_hit()
		var fire = player.fireball.instance()
		if sign(player.shot.position.x) == -1:
			fire.set_fireball_direction(-1)
			hands = Vector2(-50,0)
		else:
			fire.set_fireball_direction(1)
			hands = Vector2(50,0)
		fire.set_fireball_damage(player.power_magic_hit)
		player.get_parent().add_child(fire)
		fire.position = player.shot.global_position + hands
