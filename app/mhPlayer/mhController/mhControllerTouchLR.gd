tool
extends mhController
class_name mhControllerTouchLR


func _ready():
	deps.add("level", mhLevelStretch)
	dependences = deps.update(dependences)

func _input(event):
	if event is InputEventMouseButton:
		var app_size = deps.get("level").get_app_size()
		
		if event.is_pressed():
			if event.position.x > app_size.x / 2:
				run.right = 1
			else:
				run.left = 1
		else:
			run.right = 0
			run.left = 0
