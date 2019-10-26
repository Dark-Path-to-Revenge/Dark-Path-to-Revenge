extends KinematicBody2D

const UP 		= Vector2(0,-1)

#Load scripts
var movement_script = load("res://scripts/player/movement.gd")
var _run = movement_script.new()

var jump_script = load("res://scripts/player/jump.gd")
var _jump = jump_script.new()

var slide_script = load("res://scripts/player/slide.gd")
var _slide = slide_script.new()

var crouch_script = load("res://scripts/player/crouch.gd")
var _crouch = crouch_script.new()

onready var node = $AnimatedSprite

func apply_gravity():
	Global.move.y += Global.gravity

func run():
	_run.run(node, is_on_floor())
	
func jump():
	_jump.jump(node, is_on_floor())

func slide():
	_slide.slide(node, $Upper, $Slide, is_on_floor())

func crouch():
	_crouch.crouch(node, $Upper, $Bottom, is_on_floor())

func read_inputs():
	apply_gravity()
	run()
	#BUG NO SLIDE
	slide()
	jump()
	crouch()
	#attack()
	#magic()
	#special()

func _ready():
	node.playing = true
	
func _process(delta):
	read_inputs()
	Global.move = move_and_slide(Global.move, UP)
