tool
extends Camera2D
class_name mhCamera

var deps = preload("res://app/libs/mhDeps.gd").new(self, "_post_update_dependences")
export(Dictionary) var dependences setget _set_dependences


func _set_dependences(new_dependences):
	dependences = deps.update(new_dependences)

func _post_update_dependences(new_components_name=null):
	if deps.get("background"):
		set_limits(deps.get("background").location_size)

func _ready():
	deps.add("background", mhBackground)
	deps.set_connection("background", "location_size_changed", "set_limits")
	dependences = deps.update(dependences)

func set_limits(limits):
	if limits:
		limit_top = limits.position.y
		limit_left = limits.position.x
		limit_right = limits.end.x
		limit_bottom = limits.end.y
