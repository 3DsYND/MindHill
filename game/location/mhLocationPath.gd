tool
extends mhLocation
class_name mhLocatioinPath

export(Curve2D) var curve setget set_curve
var path


func _init():
	utils.remove_children(self)
	path = Path2D.new()
	add_child(path)

func set_curve(new_curve):
	curve = new_curve
	path.curve = new_curve

func add_to_location():
	var follow = PathFollow2D.new()
	path.call_deffered("add_child", follow)
	return follow

func move(node, vector):
	pass