extends KinematicBody2D

#ANIMACOES
func set_jump(node, type):
	match type:
		"jump":
			node.animation = "jump"
			Global.move.y = Global.jumpforce
			Global.double_jump = true
		"salt":
			node.animation = "salt"
			Global.move.y = Global.jumpforce
			Global.double_jump = false

#ACOES
func movement(node, onfloor):
	#anda para esquerda ou para direita ou fica parado
	if Input.is_action_pressed("ui_left"):
		node.flip_h = true
		Global.move.x = -Global.speedX
		if onfloor:
			node.animation = "run"
	elif Input.is_action_pressed("ui_right"):
		node.flip_h = false
		Global.move.x = Global.speedX
		if onfloor:
			node.animation = "run"
	else:
		Global.move.x = 0
		if onfloor:
			node.animation = "idle"
			node.get_sprite_frames().set_animation_speed("idle", 5.0)
			Global.gravity = 10

func jump(node, onfloor):
	
	if onfloor:
		if Input.is_action_just_pressed("ui_jump") and !Global.double_jump:
			set_jump(node, "jump")
	else:
		#pula uma segunda vez	
		if Input.is_action_just_pressed("ui_jump") and Global.double_jump:
			set_jump(node, "salt")