extends Node

func _ready():
	if File.new().file_exists(global.save_file_name):
		$MENU/HBOX/VBOX/ContinueGame.disabled = false

func _on_NewGame_pressed():
	global.show_level()

func _on_ContinueGame_pressed():
	global.load_game()

func _on_Quit_pressed():
	get_tree().quit()
