extends Node

func _on_NewGame_pressed():
	get_tree().change_scene("res://scenes/level1.tscn")

func _on_ContinueGame_pressed():
	pass # Aprender como fazer isso funcionar

func _on_Quit_pressed():
	get_tree().quit()
