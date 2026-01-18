extends Area2D

signal collect_snack

@onready var game_manager: Node = %GameManager

func _on_body_entered(_body: Node2D) -> void:
	collect_snack.emit()
	queue_free()
