extends CharacterBody2D

signal Died


@export var cat_name: String
@export var animated_sprite: AnimatedSprite2D

@export var jump_height: int
@export var move_speed: int

@onready var safe_spot_detector: RayCast2D = $SafeSpotDetector
@onready var ground_detector: RayCast2D = $GroundDetector
@onready var game_manager: Node = %GameManager
@onready var explosion_sprite: AnimatedSprite2D = $ExplosionSprite
@onready var state_machine: Node = $StateMachine


var dead = false
var last_safe_position


func _ready() -> void:
	Died.connect(game_manager.cat_died)
	last_safe_position = position


func _physics_process(_delta: float) -> void:
	if not dead:
		
		if self.is_on_floor() and safe_spot_detector.is_colliding():
			last_safe_position = position
		
		move_and_slide()


func change_state_to(state_name: String):
	state_machine.on_child_transition(state_machine.current_state, state_name)
	


func _on_died(_cat_name: String) -> void:
	change_state_to("fall")
	dead = true
	animated_sprite.flip_v = true
	explosion_sprite.play("explode")


func respawn() -> void:
	change_state_to("rest")
	dead = false
	animated_sprite.flip_v = false
	position = last_safe_position


func _on_respawn_timer_timeout() -> void:
	respawn()
