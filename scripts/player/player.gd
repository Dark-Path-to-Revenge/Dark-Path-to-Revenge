extends KinematicBody2D

onready var animated = $AnimatedSprite
onready var box_upper = $Upper
onready var box_bottom = $Bottom
onready var box_slide = $Slide

var movement = load("res://scripts/player/movement.gd").new()
var jump = load("res://scripts/player/jump.gd").new()
var crouch = load("res://scripts/player/crouch.gd").new()
var slide = load("res://scripts/player/slide.gd").new()
var attack = load("res://scripts/player/attack_sword.gd").new()

#variaveis de controle de movimento
var move = Vector2()
var speedX = 100
var jumpforce = -350
var gravity = 10
var dalta = 1
#variaveis de controle de acao
var climb_ladder = false
var climb_fall = false
var crouched = false
var sliding = false
# variaveis de ataque no ar
var air_attacking = false
var air_chain_atk = false
var air_attacking_2 = false
# variaveis de ataque no solo
var attacking = false
var chain_atk_1_2 = false
var attacking_2 = false
var chain_atk_2_3 = false
var attacking_3 = false

func _process(delta):
	self.dalta = dalta
	move.y += gravity
	movement.run(self)
	jump.run(self)
	crouch.run(self)
	slide.run(self)
	attack.run(self)
	#magic.run(self)
	#special.run(self)
	move = move_and_slide(move, Global.UP)
