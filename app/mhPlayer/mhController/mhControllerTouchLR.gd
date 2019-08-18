tool
extends mhController
class_name mhControllerTouchLR


func _ready():
	deps.add("level", mhLevelStretch)
	dependences = deps.update(dependences)

func _input(event):
	if event is InputEventScreenTouch:
		var app_size = deps.get("level").get_app_size()
		var run_arrow = "run_left" if event.position.x > app_size.x / 2 else "run_right"
		
		if event.is_pressed():
			button[run_arrow] = 1
		else:
			button[run_arrow] = 0
	
		emit_signal_input()
