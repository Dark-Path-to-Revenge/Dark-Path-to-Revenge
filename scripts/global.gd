extends Node

const save_file = 'user://DPTR.save'
const UP = Vector2(0,-1)

var level = -1
var player
var data
var is_load_game = false

func init_player(player):
	self.player = player
	if is_load_game:
		player.life = data.life
		player.energy = data.energy

func next_level():
	level += 1
	if level > 1:
		var save_game = File.new()
		save_game.open(save_file, File.WRITE)
		data = {
			'level': level,
			'life': player.life,
			'energy': player.energy,
			'lives': player.live
			}
		save_game.store_var(data)
		save_game.close()
	show_level()

func load_game():
	is_load_game = true
	var save_game = File.new()
	save_game.open(save_file, File.READ)
	data = save_game.get_var()
	save_game.close()

	level = data.level
	show_level()

func show_level():
	get_tree().change_scene('res://scenes/levels/fase_'+ str(level) +'.tscn')
