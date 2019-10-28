func reset(player, type):
	player.attacking		= false
	player.air_attacking	= false
	player.attacking_2		= false
	player.attacking_3		= false
	player.chain_atk_1_2	= false
	player.chain_atk_2_3	= false
	
	if type == "idle" :
		player.animated.animation = "idle"
	else:
		player.animated.animation = "jump"
		player.animated.set_frame(2)

func ground_attack(player):
	if Input.is_action_just_pressed("ui_attack") and !player.attacking:
		player.attacking = true
		player.animated.animation = "attack_1"
		player.animated.get_sprite_frames().set_animation_speed("attack_1", 8.0)
	if Input.is_action_just_released("ui_attack") :
		player.chain_atk_1_2 = true
	if Input.is_action_just_pressed("ui_attack") and  player.chain_atk_1_2:
		player.attacking_2 = true
	if Input.is_action_just_released("ui_attack") and player.attacking_2:
		player.chain_atk_2_3 = true
	if Input.is_action_just_pressed("ui_attack") and player.chain_atk_2_3:
		player.attacking_3 = true

	if player.animated.animation == "attack_1" and player.animated.frame == player.animated.frames.get_frame_count("attack_1")-1:
		if player.attacking_2:	
			player.animated.animation = "attack_2"
			player.animated.get_sprite_frames().set_animation_speed("attack_2", 8.0)
			player.attacking_2 = false	
			player.chain_atk_1_2 = false
		else:
			reset(player, "idle")
	elif player.animated.animation == "attack_2" and player.animated.frame == player.animated.frames.get_frame_count("attack_2")-1:
		if player.attacking_3 and player.chain_atk_2_3:	
			player.animated.animation = "attack_3"
			player.animated.get_sprite_frames().set_animation_speed("attack_3", 8.0)
		else:
			reset(player, "idle")
	elif player.animated.animation == "attack_3" and player.animated.frame == player.animated.frames.get_frame_count("attack_3")-1:
		player.attacking_3 = false	
		player.chain_atk_2_3 = true
		reset(player, "idle")
	elif player.attacking or player.attacking_2 :
		player.move.x = 0

func air_attack(player):
	if Input.is_action_just_pressed("ui_attack"):
		player.animated.animation = "air_attack_1"
		player.animated.get_sprite_frames().set_animation_speed("air_attack_1", 8.5)
	if Input.is_action_just_released("ui_attack") and !player.air_chain_atk:
		player.air_chain_atk = true
	if Input.is_action_just_pressed("ui_attack") and player.air_chain_atk:
		player.air_attacking_2 = true
		
	if player.animated.animation == "air_attack_1" and player.animated.frame == player.animated.frames.get_frame_count("air_attack_1")-1:
		if player.air_attacking_2:
			player.animated.animation = "air_attack_2"
			player.animated.get_sprite_frames().set_animation_speed("air_attack_2", 8.5)
			player.air_attacking_2 = false	
			player.air_chain_atk = false
		else:
			reset(player, "jump")	
	elif player.animated.animation == "air_attack_2" and player.animated.frame == player.animated.frames.get_frame_count("air_attack_2")-1:
		reset(player, "jump")

func run(player):
	if player.is_on_floor() and !player.sliding and !player.crouched:
		ground_attack(player)
	if !player.is_on_floor() and !player.climb_ladder and !player.climb_fall and player.air_attacking:
		air_attack(player)