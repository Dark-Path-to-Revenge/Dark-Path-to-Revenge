extends Node2D

export var id = 1
export var value = 25

func grab_item(id, value, body):
	match id:
		#pocao de vida
		1: 
			if global.HP+value > global.maxHP:
				body.update_health(global.maxHP)
			else:
				body.update_health(global.HP+value)
		#pocao de mana
		2: 
			if global.MP+value > global.maxMP:
				global.MP = global.maxMP
			else:
				global.MP = global.MP+value


func _on_Area2D_body_entered(body):
	if body.is_in_group("player"):
		grab_item(id, value, body)
		queue_free()