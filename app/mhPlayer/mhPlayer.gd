tool
extends Node2D
class_name mhPlayer

var deps:mhDependences
export(Dictionary) var dependences setget _set_dependences


func _set_dependences(new_dependences):
	if not deps:
		dependences = new_dependences
	else:
		dependences = deps.update(new_dependences)

func _ready():
	set_process(false)
	
	deps = mhDependences.new(self, "_post_update_dependences", "_pre_update_dependences")
	deps.add("controller", mhController)
	dependences = deps.update(dependences)
	
	if deps.get("controller") and not Engine.is_editor_hint():
		set_process(true)

func _process(delta):
	position = deps.get("controller").get_position()
