extends Node2D

export var direction = 1
export var damage = 20
export var speed = 400

var velocity = Vector2()

func set_fireball_damage(dmg):
	damage = dmg

func set_fireball_direction(dir):
	direction = dir
	if direction == -1:
		$animated.flip_h = true
	else:
		$animated.flip_h = false

func _physics_process(delta):
	velocity.x = speed * delta * direction
	translate(velocity)


func _on_Area2D_body_entered(body):
	if body.is_in_group('enemy'):
		body.hit(damage)
		speed = 0
		$animated.play('explode')
		yield($animated, 'animation_finished')
		queue_free()

func _on_VisibilityNotifier2D_screen_exited():
	queue_free()
