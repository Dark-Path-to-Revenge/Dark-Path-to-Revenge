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

func jump(node, onfloor):
	
	if onfloor:
		if Input.is_action_just_pressed("ui_jump") and !Global.double_jump and !Global.sliding and !Global.crouch:
			set_jump(node, "jump")
	else:
		#pula uma segunda vez	
		if Input.is_action_just_pressed("ui_jump") and Global.double_jump:
			set_jump(node, "salt")