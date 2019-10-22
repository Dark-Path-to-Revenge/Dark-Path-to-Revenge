extends KinematicBody2D

const UP 		= Vector2(0,-1)
var move 		= Vector2()
var respawn 	= Vector2(0,0)

export var speedX 		= 100
export var jumpforce 	= -350
export var gravity 		= 10

var double_jump		= false
var climb_ladder	= false
var climb_fall		= false
var ducking			= false
var sliding			= false
# variaveis de ataque aereo
var air_attacking	= false
var air_chain_atk	= false
var air_attacking_2	= false
# variaveis de ataque no solo
var attacking		= false
var chain_atk_1_2	= false
var attacking_2		= false
var chain_atk_2_3	= false
var attacking_3		= false

# gerencia as animacoes de ataques
func set_attack(type, time):
	match type:
		"atk_1":
			$AnimatedSprite.animation = "attack_1"
			$AnimatedSprite.get_sprite_frames().set_animation_speed("attack_1", time)
		"atk_2":
			$AnimatedSprite.animation = "attack_2"
			$AnimatedSprite.get_sprite_frames().set_animation_speed("attack_2", time)
		"atk_3":
			$AnimatedSprite.animation = "attack_3"
			$AnimatedSprite.get_sprite_frames().set_animation_speed("attack_3", time)
		"air_atk_1":
			$AnimatedSprite.animation = "air_attack_1"
			$AnimatedSprite.get_sprite_frames().set_animation_speed("air_attack_1", time)
		"air_atk_2":
			$AnimatedSprite.animation = "air_attack_2"
			$AnimatedSprite.get_sprite_frames().set_animation_speed("air_attack_2", time)
# gerencia a volta ao estado anterior
func reset_state(state):
	match state:
		"idle":
			$AnimatedSprite.animation = "idle"
			$AnimatedSprite.get_sprite_frames().set_animation_speed("idle", 5.0)
			gravity = 10
			attacking		= false
			air_attacking	= false
			attacking_2		= false
			attacking_3		= false
			chain_atk_1_2	= false
			chain_atk_2_3	= false
		"jump":
			$AnimatedSprite.animation = "jump"
			$AnimatedSprite.set_frame(2)
			air_attacking = false 
			air_attacking_2 = false
			air_chain_atk = false	
# gerencia os ataques
func handle_attacks():
	if is_on_floor() and !sliding:
		handle_combo_attack()
	if !is_on_floor() and !climb_ladder and !climb_fall and air_attacking:
		handle_air_combo_attack()
# gerencia os ataques no solo
func handle_combo_attack():
	
	if Input.is_action_just_pressed("ui_attack") and !attacking:
		handle_state("attack")
	if Input.is_action_just_released("ui_attack") :
		chain_atk_1_2 = true
	if Input.is_action_just_pressed("ui_attack") and  chain_atk_1_2:
		attacking_2 = true
	if Input.is_action_just_released("ui_attack") and attacking_2:
		chain_atk_2_3 = true
	if Input.is_action_just_pressed("ui_attack") and chain_atk_2_3:
		attacking_3 = true
	
	if $AnimatedSprite.animation == "attack_1" and $AnimatedSprite.frame == $AnimatedSprite.frames.get_frame_count("attack_1")-1:
		if attacking_2:	
			set_attack("atk_2", 6.0) 
			attacking_2 = false	
			chain_atk_1_2 = false
		else:
			reset_state("idle")
	elif $AnimatedSprite.animation == "attack_2" and $AnimatedSprite.frame == $AnimatedSprite.frames.get_frame_count("attack_2")-1:
		if attacking_3 and chain_atk_2_3:	
			set_attack("atk_3", 5.0)
		else:
			reset_state("idle")
	elif $AnimatedSprite.animation == "attack_3" and $AnimatedSprite.frame == $AnimatedSprite.frames.get_frame_count("attack_3")-1:
		attacking_3 = false	
		chain_atk_2_3 = true
		reset_state("idle")
	elif attacking or attacking_2 :
		move.x = 0
# gerencia os ataques no ar
func handle_air_combo_attack():
	
	if Input.is_action_just_pressed("ui_attack"):
		handle_state("air_attack")
	if Input.is_action_just_released("ui_attack") and !air_chain_atk:
		air_chain_atk = true
	if Input.is_action_just_pressed("ui_attack") and air_chain_atk:
		air_attacking_2 = true
		
	if $AnimatedSprite.animation == "air_attack_1" and $AnimatedSprite.frame == $AnimatedSprite.frames.get_frame_count("air_attack_1")-1:
		if air_attacking_2:
			set_attack("air_atk_2", 8.0) 
			air_attacking_2 = false	
			air_chain_atk = false
		else:
			reset_state("jump")
	elif $AnimatedSprite.animation == "air_attack_2" and $AnimatedSprite.frame == $AnimatedSprite.frames.get_frame_count("air_attack_2")-1:
		reset_state("jump")
# gerencia as teclas apertadas
func get_inputs():
	#FORA DA ESCADA
	if !climb_ladder:
		if !attacking :
			#anda para esquerda ou para direita ou fica parado
			if Input.is_action_pressed("ui_left"):
				handle_state("left")
			elif Input.is_action_pressed("ui_right"):
				handle_state("right")
			else:
				move.x = 0
				if is_on_floor() :
					handle_state("idle")

		if is_on_floor():
			climb_fall = false
			#pula uma vez
			if Input.is_action_just_pressed("ui_jump") and !ducking and !sliding and !attacking:
				handle_state("jump")
			#se agacha	
			if Input.is_action_pressed("ui_down") and !attacking and move.x == 0 :
				handle_state("duck_on")
			#se estiver agachado se levanta
			if Input.is_action_just_released("ui_down"):
				handle_state("duck_off")
			#desliza	
			if Input.is_action_pressed("ui_slide") and !attacking:
				handle_state("slide_on")
			if Input.is_action_just_released("ui_slide") and sliding:
				handle_state("slide_off")
				
		else:
			#pula uma segunda vez	
			if Input.is_action_just_pressed("ui_jump") and double_jump:
				handle_state("salt")
			#cai	
			if climb_fall :
				handle_state("fall")
	#NA ESCADA
	else:
		handle_state("ladder")
# gerencia os estados do personagem
func handle_state(state):
	
	match state:
		"idle":
			reset_state("idle")
		"left":
			$AnimatedSprite.flip_h = true
			if !ducking :
				move.x = -speedX
			if is_on_floor():
				$AnimatedSprite.animation = "run"
		"right":
			$AnimatedSprite.flip_h = false
			if !ducking :
				move.x = speedX
			if is_on_floor():
				$AnimatedSprite.animation = "run"
		"jump":
			$AnimatedSprite.animation = "jump"
			move.y = jumpforce
			double_jump = true
			# pode atacar enquanto pula
			air_attacking = true
		"salt":
			$AnimatedSprite.animation = "salt"
			move.y = jumpforce
			double_jump = false
			# nao pode atacar enquanto da o pulo duplo
			air_attacking = false
		"fall":
			$AnimatedSprite.animation = "fall"
			double_jump = false
		"ladder":
			move.x = 0
			$AnimatedSprite.animation = "ladder"
			if Input.is_action_pressed("ui_up"):
				move.y = -speedX
			elif Input.is_action_pressed("ui_down"):
				move.y = speedX
			else:
				$AnimatedSprite.set_frame(0) 
				move.y = 0
		"duck_on":
			$AnimatedSprite.animation = "duck"
			$Upper.set_disabled(true)
			$Bottom.set_disabled(false)
			ducking = true
		"duck_off":
			$Bottom.set_disabled(true)
			$Upper.set_disabled(false)
			ducking = false
		"slide_on":
			sliding = true
			$Upper.set_disabled(true)
			$Slide.set_disabled(false)
			$AnimatedSprite.animation = "slide"
			if $AnimatedSprite.flip_h == true:
				move.x = -100
			else:
				move.x = 100
		"slide_off":
			sliding = false
			$Slide.set_disabled(true)
			$Upper.set_disabled(false)
		"attack":
			attacking = true
			set_attack("atk_1", 7.0)
			#enable atk hitbox
		"air_attack":
			set_attack("air_atk_1", 8.5)
			#enable atk hitbox
# inicializacao
func _ready():
	$Bottom.set_disabled(true)
	$Slide.set_disabled(true)
	$AnimatedSprite.animation = "idle"
# processamento
func _process(delta):
	move.y += gravity
	$AnimatedSprite.playing = true
	get_inputs()
	handle_attacks()
		
	move = move_and_slide(move,UP)
