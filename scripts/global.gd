extends Node

# pontos de vida
var HP		= 100
# pontos de mana
var MP		= 0
# almas concedem coragem
var SOULS	= 0
# moedas compram melhorias
var COINS	= 0
# reliquias permitem o uso de habilidades epeciais
var RELICS	= 0
# respawn atual na fase
var respawn 	= Vector2(0,0)

#variaveis de controle de movimento
var move 			= Vector2()
var speedX 			= 100
var jumpforce 		= -350
var gravity 		= 10
#variaveis de controle de acao
var double_jump		= false
var climb_ladder	= false
var climb_fall		= false
var ducking			= false
var sliding			= false
# variaveis de ataque no ar
var air_attacking	= false
var air_chain_atk	= false
var air_attacking_2	= false
# variaveis de ataque no solo
var attacking		= false
var chain_atk_1_2	= false
var attacking_2		= false
var chain_atk_2_3	= false
var attacking_3		= false