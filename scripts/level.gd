extends Node2D

func _ready():
	$end_level.connect('body_entered', self, 'end_level')

func end_level(body):
	if body.is_in_group('player'):
		global.next_level()

func _on_death_zone_body_entered(body):
	if body.is_in_group('player'):
		body.hit(body.life)

func _on_respawn_body_entered(body):
	if body.is_in_group('player'):
		body.respawn = body.global_position
