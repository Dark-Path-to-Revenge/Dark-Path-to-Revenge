extends KinematicBody2D

var movement = load("res://scripts/player/movement.gd").new()
var jump = load("res://scripts/player/jump.gd").new()
var crouch = load("res://scripts/player/crouch.gd").new()
var slide = load("res://scripts/player/slide.gd").new()
var attack_sword = load("res://scripts/player/attack_sword.gd").new()

onready var animated = $AnimatedSprite
onready var box_upper = $Upper
onready var box_bottom = $Bottom
onready var box_slide = $Slide

export var gravity = 10
export var speed_moviment = 200
export var jump_force = 350

var move = Vector2()
var dalta = 1
var is_in_action = false

func _process(delta):
	self.dalta = dalta
	move.y += gravity

	movement.run(self)
	crouch.run(self)
	slide.run(self)
	jump.run(self)
	attack_sword.run(self)
	#magic.run(self)
	#special.run(self)

	move = move_and_slide(move, global.UP)
