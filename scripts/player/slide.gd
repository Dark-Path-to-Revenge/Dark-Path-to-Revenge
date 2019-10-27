var limit_time = 30
var count_time = 0

func run(player):
	if (Input.is_action_pressed("ui_slide")
			and player.is_on_floor() and !player.attacking
			and !player.crouched and count_time < limit_time):
		player.sliding = true
		count_time += 1
		player.box_slide.set_disabled(true)
		player.box_upper.set_disabled(false)
		player.animated.animation = "slide"
		player.move.x = -180 if player.animated.flip_h else 180
	elif Input.is_action_just_released("ui_slide") and player.sliding:
		player.sliding = false
		count_time = 0
		player.box_upper.set_disabled(true)
		player.box_slide.set_disabled(false)
