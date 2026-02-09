extends Node

class_name CatState

signal Transitioned


@export var cat: CharacterBody2D

var state_name: String
var jump_velocity: float
var direction: float
var jump_action_name: String
var move_left_action_name: String
var move_right_action_name: String


func _ready() -> void:
	if cat:
		jump_action_name = "%s_jump" % cat.cat_name 
		move_left_action_name = "%s_move_left" % cat.cat_name
		move_right_action_name = "%s_move_right" % cat.cat_name
		
		jump_velocity = -1 * cat.jump_height


func set_state_name(_state_name: String):
	state_name = _state_name


func Enter():
	print(cat.name + " enter: " + state_name)
	cat.animated_sprite.play(state_name)
	
	
func Exit():
	#print(cat.name + " exit: " + state_name)
	pass
	
	
func Update(_delta: float):
	pass
	
	
func Physics_update(_delta: float):
	if not cat.dead:
		apply_gravity(_delta)
		handle_horizontal_move()
		handle_jump()
		turn_horizontal()



func handle_horizontal_move():
		direction = Input.get_axis(move_left_action_name, move_right_action_name)
		if direction:
			cat.velocity.x = direction * cat.move_speed
		else:
			cat.velocity.x = move_toward(cat.velocity.x, 0, cat.move_speed)


func apply_gravity(delta: float):
	if not cat.is_on_floor():
		cat.velocity += cat.get_gravity() * delta
 

func handle_jump():
		if Input.is_action_just_pressed(jump_action_name) and cat.is_on_floor():
			cat.velocity.y = jump_velocity


func turn_horizontal():
		if direction == 1:
			cat.animated_sprite.flip_h = false
		elif direction == -1:
			cat.animated_sprite.flip_h = true
