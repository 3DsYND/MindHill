extends Node

var current_scene = null


func _ready():
	var root = get_tree().get_root()
	current_scene = root.get_child(root.get_child_count() - 1)

func get_component(name, node=null):
	if not node: node = current_scene
	var nodes = node.get_children()
	for component in nodes:
		print(component.type)
		if "type" in component and component.type == name:
			return component
	return null