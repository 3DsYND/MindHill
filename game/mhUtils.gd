tool
extends Node

func remove_children(node):
	for child in node.get_children():
		node.remove_child(child)
		child.queue_free()

func _init():
	print("init", is_inside_tree())
func _ready():
	print("_ready", is_inside_tree())