extends Node

var current_scene

func _ready():
    var root = get_tree().get_root()
    current_scene = root.get_child(root.get_child_count() -1)

func get_component(name):
	var nodes = current_scene.get_children()
	for node in nodes:
		if "type" in node:
			return node
	return null