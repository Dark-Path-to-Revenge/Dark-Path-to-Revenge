# variaveis de ataque no ar
var air_chain_atk = false
var air_attacking_2 = false
# variaveis de ataque no solo
var attacking = false
var chain_atk_1_2 = false
var attacking_2 = false
var chain_atk_2_3 = false
var attacking_3 = false

func reset(player, type):
	attacking		= false
	attacking_2		= false
	attacking_3		= false
	chain_atk_1_2	= false
	chain_atk_2_3	= false
	
	if type == "idle" :
		player.animated.animation = "idle"
	else:
		player.animated.animation = "jump"
		player.animated.set_frame(2)

func ground_attack(player):
	if Input.is_action_just_released("ui_attack"):
		player.is_in_action = true
		chain_atk_1_2 = true
		if !attacking:
			attacking = true
			player.animated.animation = "attack_1"
			player.animated.get_sprite_frames().set_animation_speed("attack_1", 8.0)
		if chain_atk_1_2:
			attacking_2 = true
		if attacking_2:
			chain_atk_2_3 = true
		if chain_atk_2_3:
			attacking_3 = true

	if player.animated.animation == "attack_1" and player.animated.frame == player.animated.frames.get_frame_count("attack_1")-1:
		if attacking_2:	
			player.animated.animation = "attack_2"
			player.animated.get_sprite_frames().set_animation_speed("attack_2", 8.0)
			attacking_2 = false	
			chain_atk_1_2 = false
		else:
			reset(player, "idle")
	elif player.animated.animation == "attack_2" and player.animated.frame == player.animated.frames.get_frame_count("attack_2")-1:
		if attacking_3 and chain_atk_2_3:	
			player.animated.animation = "attack_3"
			player.animated.get_sprite_frames().set_animation_speed("attack_3", 8.0)
		else:
			reset(player, "idle")
	elif player.animated.animation == "attack_3" and player.animated.frame == player.animated.frames.get_frame_count("attack_3")-1:
		attacking_3 = false	
		chain_atk_2_3 = true
		reset(player, "idle")
	elif attacking or attacking_2 :
		player.move.x = 0

func air_attack(player):
	if Input.is_action_just_pressed("ui_attack"):
		player.is_in_action = true
		player.animated.animation = "air_attack_1"
		player.animated.get_sprite_frames().set_animation_speed("air_attack_1", 8.5)
		if !air_chain_atk:
			air_chain_atk = true
		if air_chain_atk:
			air_attacking_2 = true
		
	if player.animated.animation == "air_attack_1" and player.animated.frame == player.animated.frames.get_frame_count("air_attack_1")-1:
		if air_attacking_2:
			player.animated.animation = "air_attack_2"
			player.animated.get_sprite_frames().set_animation_speed("air_attack_2", 8.5)
			air_attacking_2 = false	
			air_chain_atk = false
		else:
			reset(player, "jump")
	elif player.animated.animation == "air_attack_2" and player.animated.frame == player.animated.frames.get_frame_count("air_attack_2")-1:
		reset(player, "jump")

func run(player):
	if player.is_on_floor():
		ground_attack(player)
	elif player.animated.animation == "jump":
		air_attack(player)
