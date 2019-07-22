tool
extends Camera2D
class_name mhCamera

var deps:mhDependences
export(Dictionary) var dependences setget _set_dependences


func _set_dependences(new_dependences):
	if not deps:
		dependences = new_dependences
	else:
		dependences = deps.update(new_dependences)

func _post_update_dependences(new_components_name=null):
	if deps.get("background"):
		set_limits(deps.get("background").location_size)

func _ready():
	deps = mhDependences.new(self, "_post_update_dependences")
	deps.add("background", mhBackground)
	deps.set_connection("background", "location_size_changed", "set_limits")
	dependences = deps.update(dependences)
	_post_update_dependences()

func set_limits(limits):
	if limits:
		limit_top = limits.position.y
		limit_left = limits.position.x
		limit_right = limits.end.x
		limit_bottom = limits.end.y