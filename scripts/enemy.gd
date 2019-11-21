class_name Enemy extends KinematicBody2D

onready var animated = $animated
onready var player = get_node(target)

export var life = 100
export var power_hit = 10
export var attack_frame_start = 15
export var attack_frame_end = 19
export (NodePath) var target
export var speed = 8000

var player_entered = false
var attacked = false

func _physics_process(delta):
	animated.flip_h = player.position < position
	var distance2Hero = global_position.distance_to(player.global_position)

	if animated.animation == 'attack':
		attack()
	elif player_entered:
		animated.play('attack')
		yield(animated, 'animation_finished')
		animated.animation = 'idle'
	elif distance2Hero < 300:
		animated.animation = 'run'
		var dir = (player.global_position - global_position).normalized()
		dir.y = 0
		move_and_slide(dir * speed * delta)
	else:
		animated.animation = 'idle'

func attack():
	if attack_frame_start <= animated.frame and animated.frame <= attack_frame_end:
		if player_entered and not attacked:
			attacked = true
			player.hit(power_hit)
			print(animated.frame)
			print(animated.frames.get_frame_count('attack'))
	else:
		attacked = false

func _on_attack_entered(body):
	if body == player:
		player_entered = true

func _on_attack_exited(body):
	if body == player:
		player_entered = false
