extends Node

const save_file_name = 'user://DPTR.save'
const UP = Vector2(0,-1)

var level = 0
var player
var save
var is_load_game = false
var is_gameover = false

func init_player(player):
	self.player = player
	if is_load_game:
		player.life = save.life
		player.energy = save.energy
		player.lives = save.lives

func gameover():
	level = 0
	is_load_game = false
	is_gameover = true
	get_tree().change_scene('res://scenes/levels/TitleScreen.tscn')

func next_level():
	level += 1
	if level > 1:
		var save_file = File.new()
		save_file.open(save_file_name, File.WRITE)
		save = {
			'level': level,
			'life': player.life,
			'energy': player.energy,
			'lives': player.lives
			}
		save_file.store_var(save)
		save_file.close()
	show_level()

func load_game():
	is_load_game = true
	var save_file = File.new()
	save_file.open(save_file_name, File.READ)
	save = save_file.get_var()
	save_file.close()

	level = save.level
	show_level()

func show_level():
	get_tree().change_scene('res://scenes/levels/fase_'+ str(level) +'.tscn')
