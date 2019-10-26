extends KinematicBody2D

func set_crouch(node, standbox, crouchbox,type):
	match type:
		"crouch_on":
			node.animation = "duck"
			standbox.set_disabled(true)
			crouchbox.set_disabled(false)
			Global.crouch = true
		"crouch_off":
			crouchbox.set_disabled(true)
			standbox.set_disabled(false)
			Global.crouch = false

func crouch(node, standbox, crouchbox, onfloor):
	
	if onfloor:
		#se agacha	
		if Input.is_action_pressed("ui_down") and !Global.attacking and Global.move.x == 0 :
			set_crouch(node, standbox, crouchbox,"crouch_on")
		#se estiver agachado se levanta
		if Input.is_action_just_released("ui_down"):
			set_crouch(node, standbox, crouchbox,"crouch_off")