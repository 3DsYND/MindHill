tool
extends Node
class_name mhPhysics

export(Rect2) var game_area = Rect2(0, 0, 1920, 1080) setget _set_game_area


func _ready():
	connect("script_changed", self, "_ready")
	utils.remove_children(self)

func _clamp_position(vector):
	vector.x = clamp(vector.x, game_area.position.x, game_area.end.x)
	vector.y = clamp(vector.y, game_area.position.y, game_area.end.y)
	return vector

func _set_game_area(new_area):
	game_area = new_area

func add_to_location():
	var node = Node2D.new()
	call_deferred("add_child", node)
	return node

func set_spawn(node, spawn):
	node.position = _clamp_position(spawn)

func move(node, vector):
	node.position = _clamp_position(node.position + vector)
	return node.position