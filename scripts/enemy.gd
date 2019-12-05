class_name Enemy extends KinematicBody2D

const limit_find = 99
const tile_size = 16
const vision_radius = 480

onready var animated = $animated
onready var player = get_node('../player')
onready var tile_map = get_node('../TileMap')
onready var behavior_tree = Selector.new([
		Sequence.new([
			Condition.new(self, 'is_player_in_vision'),
			Selector.new([
				Sequence.new([
					Condition.new(self, 'is_in_attack'),
					Action.new(self, 'attack')
				]),
				Sequence.new([
					Condition.new(self, 'is_attack'),
					Action.new(self, 'play_attack')
				]),
				Sequence.new([
					Selector.new([
						Condition.new(self, 'is_path_updated'),
						Condition.new(self, 'update_path'),
					]),
					Action.new(self, 'moviment')
				])
			])
		]),
		Action.new(self, 'update_to_idle')
	])

export var gravity = 900
export var jump_force = 22000
export var jump_tile = 4
export var life = 100
export var power_hit = 10
export var moviment_speed = 10000
export var attack_frame_start = 15
export var attack_frame_end = 19

var delta
var path = []
var map_player_position
var move = Vector2()
var player_entered = false
var attacked = false
var is_jump = false

func _ready():
	add_to_group('enemy')
	add_to_group('alive')

func _physics_process(delta):
	self.delta = delta
	if life > 0:
		move.x = 0
		move.y += gravity * delta
		behavior_tree.run()
		move_and_slide(move, global.UP)

func is_player_in_vision():
	return position.distance_to(player.position) < vision_radius

func is_attack():
	return player_entered and is_on_floor()

func is_path_updated():
	if not map_player_position:
		return false
	if path == null:
		return true
	var this = (position / tile_size).floor()
	var pos = (player.position / tile_size).floor()
	pos.y += 2
	while tile_map.get_cellv(pos) < 0 and pos.y <= limit_find:
		pos.y += 1
	return pos.y == map_player_position.y and (path.size() or this.y <= pos.y)

func update_path():
	# using the A * algorithm
	path = null
	is_jump = false

	# get player and enemy positions in tilemap
	var map_position = (position / tile_size).floor()
	map_position.y += 3
	map_player_position = (player.position / tile_size).floor()
	map_player_position.y += 2
	while tile_map.get_cellv(map_player_position) < 0:
		map_player_position.y += 1
		if map_player_position.y > limit_find:
			path = []
			return false
	if map_position.y < map_player_position.y:
		path = []
		return true

	var start = Movement.new(null, map_player_position)
	var next_list = [start]
	while next_list.size() > 0:
		# take the shortest way
		var current = next_list.front()
		for el in next_list:
			if min(el.distance, current.distance) == el.distance:
				current = el
		next_list.erase(current)

		# path found
		if not current.distance:
			path = []
			while current.parent:
				current = current.parent
				path.append(current.position)
			return true

		# search tree expansion
		for direction in [1, -1]:
			var movement = Movement.new(current)
			while tile_map.get_cell(movement.position.x, movement.position.y - 1) < 0:
				movement.position.x += direction
				# path found
				if map_position == movement.position:
					movement.distance = 0
					next_list.append(movement)
					break
				movement.distance += 1
				if tile_map.get_cellv(movement.position) < 0:
					movement.position.x -= direction
					movement = Movement.new(movement)
					movement.position.x += direction
					while (tile_map.get_cellv(movement.position) < 0
							and movement.position.y - movement.parent.position.y < jump_tile):
						movement.position.y += 1
						movement.distance += 1
					if tile_map.get_cellv(movement.position) > -1:
						movement.distance += abs(movement.position.x - map_position.x)
						movement.position.x += jump_tile if direction > 0 else -jump_tile
						next_list.append(movement)
					break
	# path not found
	path = []

func moviment():
	if path == null:
		return
	animated.play('run')
	move.x = moviment_speed * delta
	if path.empty():
		animated.flip_h = player.position.x < position.x
		if animated.flip_h:
			move.x *= -1
		return
	var current = (position / tile_size).floor()
	current.y += 3
	var next = path.front()
	animated.flip_h = current.x > next.x
	if animated.flip_h:
		move.x *= -1
		if current.y == next.y and current.x - next.x == 0:
			path.pop_front()
	elif current.y == next.y and next.x - current.x == 0:
		path.pop_front()
	if is_jump:
		path.pop_front()
		is_jump = false
	elif current.y > next.y and is_on_floor():
		animated.play('idle')
		animated.play('run')
		move.y = -jump_force * delta
		is_jump = true

func update_to_idle():
	animated.animation = 'idle'

func is_in_attack():
	return animated.animation == 'attack'

func play_attack():
	animated.play('attack')
	yield(animated, 'animation_finished')
	animated.animation = 'idle'

func attack():
	if attack_frame_start > animated.frame or animated.frame > attack_frame_end:
		attacked = false
	elif player_entered and not attacked:
		attacked = true
		player.hit(power_hit)

func hit(loss):
	life -= loss
	if life <= 0:
		animated.flip_h = player.position.x > position.x
		animated.play('death')
		yield(animated, 'animation_finished')
		queue_free()

func _on_attack_entered(body):
	if body == player:
		player_entered = true

func _on_attack_exited(body):
	if body == player:
		player_entered = false

# Inner Classes

class Sequence:
	var items
	func _init(items):
		self.items = items
	func run():
		for item in items:
			if not item.run():
				return false
		return true

class Selector:
	var items
	func _init(items):
		self.items = items
	func run():
		for item in items:
			if item.run():
				return true
		return false

class Action:
	var act
	func _init(instance, funcname):
		act = funcref(instance, funcname)
	func run():
		act.call_func()
		return true

class Condition:
	var act
	func _init(instance, funcname):
		act = funcref(instance, funcname)
	func run():
		return act.call_func()

class Movement:
	var parent
	var position
	var distance
	func _init(parent, position = null):
		self.parent = parent
		self.position = position
		self.position = position if position else parent.position
		self.distance = parent.distance if parent else -1
