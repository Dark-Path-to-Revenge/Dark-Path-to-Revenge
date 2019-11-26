class_name Enemy extends KinematicBody2D

onready var animated = $animated
onready var player = get_node(target)

export var life = 100
export var power_hit = 10
export var moviment_speed = 8000
export var attack_frame_start = 15
export var attack_frame_end = 19
export (NodePath) var target

var player_entered = false
var attacked = false

func _ready():
	add_to_group('enemy')

func _physics_process(delta):
	if life > 0:
		animated.flip_h = player.position < position
	
		if animated.animation == 'attack':
			attack()
		elif player_entered:
			animated.play('attack')
			yield(animated, 'animation_finished')
			animated.animation = 'idle'
		elif global_position.distance_to(player.global_position) < 300:
			animated.animation = 'run'
			var dir = (player.global_position - global_position).normalized()
			dir.y = 600 * delta
			dir = move_and_slide(dir * moviment_speed * delta)
		else:
			animated.animation = 'idle'

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
