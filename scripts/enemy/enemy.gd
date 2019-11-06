extends KinematicBody2D

export (NodePath) var target = null
export var speed = 8000
onready var anim = $AnimatedSprite
onready var atk = $AttackRadius/attack
var monster = self
var player = null
var can_move = true

func _ready():
	anim.animation = "idle"
	player = get_node(target)

func is_atk_stopped():
	return anim.animation == "attack" and anim.frame == anim.frames.get_frame_count("attack")-1 
	
func state(dir, delta):
	
	var distance2Hero = monster.global_position.distance_to(player.global_position)
	
	if distance2Hero < 100 : 
		anim.animation = "attack"
		can_move = false
	elif distance2Hero > 100 and distance2Hero < 300 : 
		if is_atk_stopped():
			can_move = true
		if can_move:
			anim.animation = "run"
	else:
		if is_atk_stopped():
			anim.animation = "idle"
		
	if anim.animation == "run" and distance2Hero > 50 and can_move:
		move_and_slide(dir * speed * delta)

func _physics_process(delta):
	
	var dir = (player.global_position - monster.global_position).normalized()
	dir.y = 0
	anim.flip_h = true if player.position < monster.position else false
	state(dir, delta)