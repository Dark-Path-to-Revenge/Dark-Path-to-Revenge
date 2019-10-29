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

export var gravity = 600
export var moviment_speed = 12000
export var slide_speed = 12000
export var slide_duration = 40
export var jump_force = 21000
export var jump_quantity = 2

var move = Vector2()
var delta = 0
var is_in_action = false

func _process(delta):
	self.delta = delta
	move.y += gravity * delta

	movement.run(self)
	crouch.run(self)
	slide.run(self)
	jump.run(self)
	attack_sword.run(self)
	#magic.run(self)
	#special.run(self)

	move = move_and_slide(move, global.UP)
