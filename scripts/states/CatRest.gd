extends CatState

class_name CatRest


func Enter():
	super.Enter()


func Exit():
	super.Exit()


func Update(_delta: float):
	super.Update(_delta)


func Physics_update(_delta: float):
	super.Physics_update(_delta)
	
	if cat.velocity.x != 0:
		Transitioned.emit(self, "move")
	elif !cat.is_on_floor():
		if cat.velocity.y < 0:
			Transitioned.emit(self, "jump")
	
