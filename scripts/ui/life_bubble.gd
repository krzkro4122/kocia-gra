extends Control

class_name LifeBubble

var popped = false

@onready var animated_texture_rect: AnimatedTextureRect = $AnimatedTextureRect

func _ready() -> void:
	pass

func pop() -> void:
	popped = true
	animated_texture_rect.play()
	

func reset() -> void:
	popped = false
	animated_texture_rect.stop()
