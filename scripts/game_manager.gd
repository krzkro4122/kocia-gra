extends Node

var score = 0
var total_points: int

@onready var snacks: Node2D = $Snacks
@onready var hud: CanvasLayer = $HUD


func _ready() -> void:
	total_points = snacks.get_child_count()
	hud.update_score(score, total_points)
	
	var snack_nodes = snacks.get_children()
	for snack in snack_nodes:
		snack.connect("collect_snack", add_score)
	

func add_score() -> void:
	score += 1
	hud.update_score(score, total_points)
	print("Score: %d / %d" % [score, total_points])
	
	win_check()
	
	
	
func win_check() -> void:
	if score == total_points:
		hud.win()
		
