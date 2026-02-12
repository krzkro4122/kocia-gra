extends Control

@export var lives: int

var bubbles: Array[LifeBubble]


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	for child in self.get_children():
		bubbles.append(child)


func sort_bubbles_descending(a: LifeBubble, b: LifeBubble):
	return a.popped > b.popped


func get_last_unpopped_bubble() -> LifeBubble:
	
	for bubble in bubbles: 
		if bubble.popped:
			continue
		else:
			return bubble
	
	return bubbles[0]


func lose_life():
	get_last_unpopped_bubble().pop()
	bubbles.sort_custom(sort_bubbles_descending)
