extends CatState

class_name CatAscend


func Enter():
	super.Enter()


func Exit():
	super.Exit()


func Update(_delta: float):
	super.Update(_delta)


func Physics_update(_delta: float):
	super.Physics_update(_delta)
	
	if cat.velocity.y < 0:
		Transitioned.emit(self, "fall")
