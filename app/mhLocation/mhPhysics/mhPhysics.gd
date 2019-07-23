tool
extends Node
class_name mhPhysics

export(bool) var _debug_info = false setget _debug_info


func add_to_location():
	var node = Node2D.new()
	node.name = "character"
	call_deferred("add_child", node)
	return node

func remove(node):
	call_deferred("remove_child", node)
	node.call_deferred("queue_free")

func set_spawn(node, spawn):
	node.position = spawn

func move(node, vector):
	node.position = node.position + vector
	return node.position

func _debug_info(is_pressed):
	if not is_pressed: return
	
	print("#### DEBUG INFO ", name, " ####")
	print_tree()
	print("\n")
