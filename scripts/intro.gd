extends Node

var img00 = load("res://assets/environment/misc/sekai.png")
var img01 = load("res://assets/environment/misc/death.png")
var img02 = load("res://assets/environment/misc/stevan.png")
var img03 = load("res://assets/environment/misc/despair.png")
var img04 = load("res://assets/environment/misc/vengeance.png")

var images = [img00,img01,img02,img03,img04]
var img_id = 1

onready var picture = $TextureRect

func _ready():
	picture.texture = images[0]

func change_img(id):
	if img_id >= 5:
		global.next_level()
	else:
		picture.texture = images[id]
		img_id += 1

func _on_DialogueUI_next_img():
	change_img(img_id)
