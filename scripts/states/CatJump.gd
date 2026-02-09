extends CatState

class_name CatJump

@onready var ground_detector: RayCast2D = $"../../GroundDetector"

func Enter():
	super.Enter()


func Exit():
	super.Exit()


func Update(_delta: float):
	super.Update(_delta)


func Physics_update(_delta: float):
	super.Physics_update(_delta)
	
	if !ground_detector.is_colliding():
		Transitioned.emit(self, "ascend")
	
	
	
