extends KinematicBody2D

func set_slide(node, standbox, slidebox,type):
	match type:
		"slide_on":
			Global.sliding = true
			standbox.set_disabled(true)
			slidebox.set_disabled(false)
			node.animation = "slide"
			if node.flip_h == true:
				Global.move.x = -180
			else:
				Global.move.x = 180
		"slide_off":
			Global.sliding = false
			slidebox.set_disabled(true)
			standbox.set_disabled(false)

func slide(node, standbox, slidebox, onfloor):
	if onfloor:
		#desliza	
		if Input.is_action_pressed("ui_slide") and !Global.attacking and !Global.crouch and !Global.double_jump:
			set_slide(node, standbox, slidebox,"slide_on")
		if Input.is_action_just_released("ui_slide") and Global.sliding:
			set_slide(node, standbox, slidebox,"slide_off")
	else:
		Global.sliding = false