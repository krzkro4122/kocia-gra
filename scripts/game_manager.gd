extends Node

var score = 0
var lives = 3
var respawn_wait_time = 2.0
var cats: Dictionary[StringName, Variant] = {}
var total_points: int
var game_is_over: bool

@onready var snacks: Node2D = $Snacks
@onready var hud: CanvasLayer = $HUD
@onready var kotki: Node2D = $Kotki


func _ready() -> void:
	total_points = snacks.get_child_count()
	hud.update_score(score, total_points)
	
	var snack_nodes = snacks.get_children()
	for snack in snack_nodes:
		snack.connect("collect_snack", add_score)
		
	for child in kotki.get_children():
		if child is CharacterBody2D:
			var cat_name = child.cat_name.to_lower()
			var cat_respawn_timer = create_respawn_timer()
			cat_respawn_timer.connect("timeout", child._on_respawn_timer_timeout)
			var cat_objects = {
				respawn_timer = cat_respawn_timer,
				reference = child
			}
			cats.set(cat_name, cat_objects)
	

func add_score() -> void:
	score += 1
	hud.update_score(score, total_points)
	print("Score: %d / %d" % [score, total_points])
	
	win_check()
	
	
func win_check() -> void:
	if score == total_points:
		hud.win()
		
	
func lose_check() -> bool:
	if lives < 1:
		hud.lose()
		game_is_over = true
		Engine.time_scale = 0.4

	return lives < 1


func cat_died(cat_name: String) -> void:
	print(cat_name + " is dead.")
	lives -= 1
	if not game_is_over:
		hud.lose_life()
	
	if not lose_check():
		var cat_objects = cats.get(cat_name)
		var respawn_timer = cat_objects.respawn_timer
		if respawn_timer:
			respawn_timer.start()


func create_respawn_timer() -> Timer:
	var timer := Timer.new()
	add_child(timer)
	timer.wait_time = respawn_wait_time
	timer.one_shot = true
	return timer
