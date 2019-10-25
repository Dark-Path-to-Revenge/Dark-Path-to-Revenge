extends Node

# gerencia as animacoes de ataques
func set_attack(node, type, time):
	match type:
		"atk_1":
			node.animation = "attack_1"
			node.get_sprite_frames().set_animation_speed("attack_1", time)
		"atk_2":
			node.animation = "attack_2"
			node.get_sprite_frames().set_animation_speed("attack_2", time)
		"atk_3":
			node.animation = "attack_3"
			node.get_sprite_frames().set_animation_speed("attack_3", time)
		"air_atk_1":
			node.animation = "air_attack_1"
			node.get_sprite_frames().set_animation_speed("air_attack_1", time)
		"air_atk_2":
			node.animation = "air_attack_2"
			node.get_sprite_frames().set_animation_speed("air_attack_2", time)