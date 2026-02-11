extends CanvasLayer

@onready var score_label: Label = $ScoreLabel
@onready var message_label: Label = $MessageLabel
@onready var health_bar: Control = $HealthBar

const formatString = 'Smaczki: %d / %d'
const winMessage = 'Zwycięstwo!'
const loseMessage = 'Przejebane :C'

var GREEN_COLOR = Color.html('#4ef54e')
var RED_COLOR = Color.html('#d10013')

func _ready() -> void:
	score_label.text = formatString % [0, 0]
	message_label.hide()


func update_score(score: int, total_points: int) -> void:
	score_label.text = formatString % [score, total_points]

func lose_life() -> void:
	health_bar.lose_life()


func win() -> void:
	print(winMessage)
	message_label.text = winMessage
	message_label.add_theme_color_override("font_color", GREEN_COLOR)
	message_label.show()
	

func lose() -> void:
	print(loseMessage)
	message_label.text = loseMessage
	message_label.add_theme_color_override("font_color", RED_COLOR)
	message_label.show()
