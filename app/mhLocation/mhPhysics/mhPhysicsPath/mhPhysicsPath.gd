tool
extends mhPhysics
class_name mhPhysicsPath

var deps = preload("res://app/libs/mhDeps.gd").new(self)
export(Dictionary) var dependences setget _set_dependences

var _path


func _set_dependences(new_dependences):
	dependences = deps.update(new_dependences)

func _ready():
	deps.add("path2d", Path2D)
	dependences = deps.update(dependences)

func add_to_location():
	var node = PathFollow2D.new()
	deps.get("path2d").call_deferred("add_child", node)
	return node

func remove(node):
	deps.get("path2d").call_deferred("remove_child", node)
	node.queue_free()

func set_spawn(node, spawn):
	node.offset = spawn.x

func move(node, vector):
	node.offset += vector.x
