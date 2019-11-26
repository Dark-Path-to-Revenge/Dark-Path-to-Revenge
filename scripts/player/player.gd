extends KinematicBody2D

const fireball = preload("res://scenes/fireball.tscn")

var movement = load('res://scripts/player/movement.gd').new()
var crouch = load('res://scripts/player/crouch.gd').new()
var slide = load('res://scripts/player/slide.gd').new()
var jump = load('res://scripts/player/jump.gd').new()
var magic = load('res://scripts/player/magic.gd').new()
var attack_sword = load('res://scripts/player/attack_sword.gd').new()

onready var animated = $animated
onready var camera = $camera
onready var body_normal = $body_normal
onready var body_crouch = $body_crouch
onready var body_slide = $body_slide
onready var attack_sword_1 = $attack_sword_1
onready var attack_sword_2 = $attack_sword_2
onready var attack_sword_3 = $attack_sword_3
onready var shot = $magic_shot

export var lives = 2
export var life = 100
export var energy = 50
export var gravity = 800
export var moviment_speed = 12000
export var slide_speed = 12000
export var slide_duration = 40
export var jump_force = 21000
export var jump_quantity = 2
export var power_hit = 10
export var power_energy_hit = 10
export var power_magic_hit = 8

var move = Vector2()
var delta = 0
var is_in_action = false
var is_left = false

var respawn = Vector2()

func _ready():
	$camera/LifeBar.set_maximum_value(life)
	$camera/LifeBar.set_current_value(life)
	$camera/EnergyBar.set_maximum_value(energy)
	$camera/EnergyBar.set_current_value(energy)
	global.init_player(self)

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
		life = 0
		is_in_action = true
		animated.play('die')
		yield(animated, 'animation_finished')
		is_in_action = false
		lives -= 1
		print(lives)
		if lives > 0:
			player_respawn(1)
		else:
			global.gameover()
	elif not is_in_action:
		is_in_action = true
		animated.play('hurt')
		yield(animated, 'animation_finished')
		is_in_action = false
		$camera/LifeBar.set_current_value(life)

func magic_hit():
	energy -= power_energy_hit
	$camera/EnergyBar.set_current_value(energy)

func plus_life(value):
	life += value
	update_life()

func update_life():
	if life > $camera/LifeBar.maximum_value:
		life = $camera/LifeBar.maximum_value
	$camera/LifeBar.set_current_value(life)

func plus_energy(value):
	energy += value
	update_energy()

func update_energy():
	if energy > $camera/EnergyBar.maximum_value:
		energy = $camera/EnergyBar.maximum_value
	$camera/EnergyBar.set_current_value(energy)

func player_respawn(sec):
	yield(get_tree().create_timer(sec), "timeout")
	set_position(respawn)
	plus_life($camera/LifeBar.maximum_value)
