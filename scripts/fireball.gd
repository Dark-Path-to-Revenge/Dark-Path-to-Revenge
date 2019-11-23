extends Node2D

export var direction = 1
export var damage = 20
export var speed = 400

var velocity = Vector2()

func set_fireball_direction(dir):
	direction = dir
	if direction == -1:
		$AnimatedSprite.flip_h = true
	else:
		$AnimatedSprite.flip_h = false

func _physics_process(delta):
	velocity.x = speed * delta * direction
	translate(velocity)
	$AnimatedSprite.play("move")


func _on_Area2D_body_entered(body):
	if body.is_in_group('enemy') and body.has_method('hit'):
		body.hit(self.damage)
		print("acertou")
		queue_free()

func _on_VisibilityNotifier2D_screen_exited():
	queue_free()
