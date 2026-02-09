extends CanvasLayer

@onready var score_label: Label = $ScoreLabel
@onready var message_label: Label = $MessageLabel

const formatString = 'Smaczki: %d / %d'
const winMessage = 'Zwycięstwo!'
const loseMessage = 'Przejebane :C'


func _ready() -> void:
	score_label.text = formatString % [0, 0]
	message_label.hide()


func update_score(score: int, total_points: int) -> void:
	score_label.text = formatString % [score, total_points]


func win() -> void:
	print(winMessage)
	message_label.text = winMessage
	message_label.modulate.hex(0x4ef54e)
	message_label.show()
	

func lose() -> void:
	print(loseMessage)
	message_label.text = loseMessage
	message_label.modulate.hex(0xd10013)
	message_label.show()
