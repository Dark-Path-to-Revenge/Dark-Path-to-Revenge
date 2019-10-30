var attack_count = 0

func ground_attack(player):
	if attack_count:
		attack_count += 1
	else:
		attack_count = 1
		player.is_in_action = true
		player.animated.play('attack_1')
		yield(player.animated, 'animation_finished')
		if attack_count > 1:
			player.animated.play('attack_2')
			yield(player.animated, 'animation_finished')
		if attack_count > 2:
			player.animated.play('attack_3')
			yield(player.animated, 'animation_finished')
		attack_count = 0
		player.is_in_action = false

func air_attack(player):
	if attack_count:
		attack_count += 1
	else:
		attack_count = 1
		player.is_in_action = true
		player.animated.play('air_attack_1')
		yield(player.animated, 'animation_finished')
		if attack_count > 1:
			player.animated.play('air_attack_2')
			yield(player.animated, 'animation_finished')
		attack_count = 0
		player.is_in_action = false

func run(player):
	if Input.is_action_just_released('ui_attack'):
		if player.is_on_floor():
			ground_attack(player)
		else:
			air_attack(player)
