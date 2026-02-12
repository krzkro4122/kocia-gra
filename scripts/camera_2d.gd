extends Camera2D

@export var player1: CharacterBody2D
@export var player2: CharacterBody2D

@export_group("Zoom settings")
@export var min_zoom_factor: float = 0.5 
@export var max_zoom_factor: float = 2.0
@export var zoom_margin: float = 200.0 # Extra space in px 
@export var zoom_speed: float = 5.0


func _process(delta: float):
	if not player1 or not player2: return
	
	var midpoint = (player1.global_position + player2.global_position) * 0.5
	self.global_position = midpoint
	
	var distance_x = abs(player1.global_position.x - player2.global_position.x) + zoom_margin
	var distance_y = abs(player1.global_position.y - player2.global_position.y) + zoom_margin

	var screen_size = get_viewport_rect().size
	var limit_w = abs(limit_right - limit_left)
	var limit_h = abs(limit_bottom - limit_top)
	
	var abs_min_zoom_x = screen_size.x / limit_w
	var abs_min_zoom_y = screen_size.y / limit_h
	var limit_min_zoom = max(abs_min_zoom_x, abs_min_zoom_y)
	
	var zoom_x = screen_size.x / distance_x
	var zoom_y = screen_size.y / distance_y
	var target_zoom_val = min(zoom_x, zoom_y)
	
	var final_min_zoom = max(min_zoom_factor, limit_min_zoom)
	target_zoom_val = clamp(target_zoom_val, final_min_zoom, max_zoom_factor)
	
	self.zoom = self.zoom.lerp(Vector2(target_zoom_val, target_zoom_val), zoom_speed * delta)
	
