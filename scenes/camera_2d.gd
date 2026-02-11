extends Camera2D

@export var player1: CharacterBody2D
@export var player2: CharacterBody2D

@export_group("Zoom settings")
@export var min_zoom: float = 0.5 
@export var max_zoom: float = 2.0
@export var zoom_margin: float = 200.0 # Extra space in px 
@export var zoom_speed: float = 5.0


func _process(delta: float):
	if not player1 or not player2: return
	
	var midpoint = (player1.global_position + player2.global_position) * 0.5
	self.global_position = midpoint
	
	var distance_x = abs(player1.global_position.x - player2.global_position.x) + zoom_margin
	var distance_y = abs(player1.global_position.y - player2.global_position.y) + zoom_margin

	var screen_size = get_viewport_rect().size
	
	var zoom_x = screen_size.x / distance_x
	var zoom_y = screen_size.y / distance_y
	
	var target_zoom_val = min(zoom_x, zoom_y)
	
	var target_zoom = Vector2(target_zoom_val, target_zoom_val)
	self.zoom = self.zoom.lerp(target_zoom, zoom_speed * delta)
	
