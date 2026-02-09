extends CatState

class_name CatLand


func Enter():
	super.Enter()


func Exit():
	super.Exit()


func Update(_delta: float):
	super.Update(_delta)


func Physics_update(_delta: float):
	super.Physics_update(_delta)
	
	if cat.is_on_floor():
		Transitioned.emit(self, "idle")
