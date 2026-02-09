extends CatState

class_name CatIdle

@onready var idle_timer: Timer = $"IdleTimer"


func Enter():
	super.Enter()
	idle_timer.start()


func Exit():
	super.Exit()
	

func Update(_delta: float):
	super.Update(_delta)


func Physics_update(_delta: float):
	super.Physics_update(_delta)
	
	if cat.is_on_floor() and !cat.velocity.is_zero_approx():
		Transitioned.emit(self, "move")
	
	if !cat.is_on_floor():
		if cat.velocity.y < 0:
			Transitioned.emit(self, "jump")
		else:
			Transitioned.emit(self, "fall")


func _on_idle_timer_timeout() -> void:
	Transitioned.emit(self, "rest")
