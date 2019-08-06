tool
extends Node2D
class_name mhPlayer

var deps = preload("res://app/libs/mhDeps.gd").new(self, "_post_update_dependences", "_pre_update_dependences")
export(Dictionary) var dependences setget _set_dependences


func _set_dependences(new_dependences):
	dependences = deps.update(new_dependences)

func _ready():
	set_process(false)
	
	deps.add("controller", mhController)
	dependences = deps.update(dependences)
	
	if deps.get("controller") and not Engine.is_editor_hint():
		set_process(true)
	
	position = deps.get("controller").get_position()

func _process(delta):
	position = deps.get("controller").get_position()
	rotation = deps.get("controller").get_rotation()
