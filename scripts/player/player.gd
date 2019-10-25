extends KinematicBody2D

const UP 		= Vector2(0,-1)

#Load scripts
var load_inputs = load("res://scripts/player/player_inputs.gd")
var my_inputs = load_inputs.new()
onready var node = $AnimatedSprite

func apply_gravity():
	Global.move.y += Global.gravity

func run():
	my_inputs.movement(node, is_on_floor())
	
func jump():
	my_inputs.jump(node, is_on_floor())
	
func read_inputs():
	apply_gravity()
	run()
	jump()
	#attack()
	#slide()
	#magic()
	#special()

func _ready():
	node.playing = true
	
func _process(delta):
	read_inputs()
	Global.move = move_and_slide(Global.move, UP)
