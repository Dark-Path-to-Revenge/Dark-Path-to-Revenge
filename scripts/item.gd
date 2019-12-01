extends Node2D

export var id = 1
export var value = 25

func _ready():
	connect('body_entered', self, '_on_body_entered')

func _on_body_entered(body):
	if body.is_in_group('alive'):
		# LIFE
		if id == 1 and body.has_method('plus_life'): 
			body.plus_life(value)
		# ENERGY
		elif id == 2 and body.has_method('plus_energy'):
			body.plus_energy(value)
		queue_free()