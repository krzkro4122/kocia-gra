extends CharacterBody2D

const cat_name = "kazik"

@export var move_speed: int = 300
@export var jump_height: int = 300

@onready var jump_velocity = -1 * jump_height
@onready var ground_detector: RayCast2D = $GroundDetector
@onready var animated_sprite: AnimatedSprite2D = $AnimatedSprite2D

var jump_action_name = "%s_jump" % cat_name 
var move_left_action_name = "%s_move_left" % cat_name
var move_right_action_name = "%s_move_right" % cat_name


func _physics_process(delta: float) -> void:
	apply_gravity(delta)
	handle_jump()
	
	var direction = handle_horizontal_move()
	turn_horizontal(direction)
	play_animation(direction)
	
	move_and_slide()


func apply_gravity(delta: float) -> void:
	if not is_on_floor():
		velocity += get_gravity() * delta
 

func handle_jump() -> void:
	if Input.is_action_just_pressed(jump_action_name) and is_on_floor():
		velocity.y = jump_velocity


func play_animation(direction: float) -> void:
	var animation_to_play = "idle"
	
	if is_on_floor():
		if direction == 0:
			animation_to_play = "idle"
		else: 
			animation_to_play = "run"
	else:
		if velocity.y > 0:
			if ground_detector.is_colliding():
				animation_to_play = "land"
			else:
				animation_to_play = "fall"
		if velocity.y < 0:
			if ground_detector.is_colliding():
				animation_to_play = "jump"
			else:
				animation_to_play = "ascend"
		
	animated_sprite.play(animation_to_play)


func handle_horizontal_move() -> float:
	var direction := Input.get_axis(move_left_action_name, move_right_action_name)
	if direction:
		velocity.x = direction * move_speed
	else:
		velocity.x = move_toward(velocity.x, 0, move_speed)
		
	return direction


func turn_horizontal(direction: float) -> void:
	if direction == 1:
		animated_sprite.flip_h = false
	elif direction == -1:
		animated_sprite.flip_h = true
