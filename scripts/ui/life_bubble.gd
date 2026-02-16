extends Control

class_name LifeBubble

var popped = false

@onready var animated_texture_rect: AnimatedTextureRect = $AnimatedTextureRect

func _ready() -> void:
	pass

func pop() -> void:
	popped = true
	animated_texture_rect.stop()
	
	animated_texture_rect.current_animation = "pop"
	animated_texture_rect.stop_at_last_frame = true
	animated_texture_rect.auto_play = false
	animated_texture_rect.play()
	

func reset() -> void:
	popped = false
	
	animated_texture_rect.stop()
	
	animated_texture_rect.current_animation = "idle"
	animated_texture_rect.stop_at_last_frame = false
	animated_texture_rect.auto_play = true
	animated_texture_rect.play()
