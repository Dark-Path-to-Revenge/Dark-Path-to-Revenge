var attack_count = 0
var multiple_attacked = 0
var enemies = []

func ground_attack(player):
	if attack_count:
		attack_count += 1
	else:
		attack_count = 1
		player.is_in_action = true
		multiple_attacked = 1
		player.animated.play('attack_1')
		enemies = player.attack_sword_1.get_overlapping_bodies()
		yield(player.animated, 'animation_finished')
		if attack_count > 1:
			multiple_attacked = 2
			player.animated.play('attack_2')
			enemies = player.attack_sword_2.get_overlapping_bodies()
			yield(player.animated, 'animation_finished')
		if attack_count > 2:
			multiple_attacked = 2.5
			player.animated.play('attack_3')
			enemies = player.attack_sword_3.get_overlapping_bodies()
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
	elif attack_count and multiple_attacked:
		for enemy in enemies:
			if enemy.is_in_group('enemy'):
				enemy.hit(multiple_attacked * player.power_hit)
		multiple_attacked = 0
