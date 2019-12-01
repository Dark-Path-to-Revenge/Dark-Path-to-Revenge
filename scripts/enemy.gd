class_name Enemy extends KinematicBody2D

onready var animated = $animated
onready var player = get_node('../player')

export var gravity = 50
export var life = 100
export var power_hit = 10
export var moviment_speed = 10000
export var attack_frame_start = 15
export var attack_frame_end = 19

var move = Vector2()
var player_entered = false
var attacked = false

func _ready():
	add_to_group('enemy')
	add_to_group('alive')

func _physics_process(delta):
	if life > 0:
		move.x = 0
		move.y += gravity * delta
		animated.flip_h = player.position.x < position.x
	
		if animated.animation == 'attack':
			attack()
		elif player_entered:
			animated.play('attack')
			yield(animated, 'animation_finished')
			animated.animation = 'idle'
		elif position.distance_to(player.position) < 300:
			animated.animation = 'run'
			move.x = moviment_speed * delta
			if animated.flip_h:
				move.x *= -1
		else:
			animated.animation = 'idle'

		move_and_slide(move)

func attack():
	if attack_frame_start > animated.frame or animated.frame > attack_frame_end:
		attacked = false
	elif player_entered and not attacked:
		attacked = true
		player.hit(power_hit)

func hit(loss):
	life -= loss
	if life <= 0:
		animated.flip_h = player.position > position
		animated.play('death')
		yield(animated, 'animation_finished')
		queue_free()

func _on_attack_entered(body):
	if body == player:
		player_entered = true

func _on_attack_exited(body):
	if body == player:
		player_entered = false
