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
onready var shot = $magic_shot

export var life = 100
export var gravity = 600
export var moviment_speed = 12000
export var slide_speed = 12000
export var slide_duration = 40
export var jump_force = 21000
export var jump_quantity = 2
export var power_hit = 10
export var magic_hit = 5

signal player_health
signal player_mana
signal player_dead

var move = Vector2()
var delta = 0
var is_in_action = false
var is_left = false

const fireball = preload("res://scenes/fireball.tscn")

func _ready():
	global.HP = life
	global.maxHP = life
	emit_signal("player_health")

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
		update_health(0)
		emit_signal("player_dead")
	else:
		update_health(life)

func update_health(value):
	global.HP = value
	life = global.HP
	emit_signal("player_health")
	
func update_mana(value):
	global.MP = value
	emit_signal("player_mana")
