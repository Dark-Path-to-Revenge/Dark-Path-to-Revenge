extends Node2D

func _ready():
	$end_level.connect('body_entered', self, 'end_level')

func end_level(body):
	if body.is_in_group('player'):
		global.next_level()
