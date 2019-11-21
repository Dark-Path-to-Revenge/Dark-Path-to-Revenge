extends KinematicBody2D

var movement = load('res://scripts/player/movement.gd').new()
var crouch = load('res://scripts/player/crouch.gd').new()
var slide = load('res://scripts/player/slide.gd').new()
var jump = load('res://scripts/player/jump.gd').new()
var magic = load('res://scripts/player/magic.gd').new()
var attack_sword = load('res://scripts/player/attack_sword.gd').new()

onready var animated = $animated
onready var body_normal = $body_normal
onready var body_crouch = $body_crouch
onready var body_slide = $body_slide
onready var attack_sword_1 = $attack_sword_1
onready var attack_sword_2 = $attack_sword_2
onready var attack_sword_3 = $attack_sword_3

export var life = 100
export var gravity = 600
export var moviment_speed = 12000
export var slide_speed = 12000
export var slide_duration = 40
export var jump_force = 21000
export var jump_quantity = 2
export var power_hit = 10

var move = Vector2()
var delta = 0
var is_in_action = false

func _physics_process(delta):
	self.delta = delta
	move.y += gravity * delta

	movement.run(self)
	crouch.run(self)
	slide.run(self)
	jump.run(self)
	magic.run(self)
	attack_sword.run(self)

	move = move_and_slide(move, global.UP)

func hit(loss):
	life -= loss
	if life <= 0:
		print('Player KILLED')
