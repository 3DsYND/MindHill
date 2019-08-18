tool
extends Camera2D
#class_name mhCamera

export(NodePath) var _background_path  setget _set_background_path
var _background

func _ready():
	_update_background()

func set_limits(limits):
	if limits:
		limit_top = limits.position.y
		limit_left = limits.position.x
		limit_right = limits.end.x
		limit_bottom = limits.end.y

func _set_background_path(new_path):
	_background_path = new_path
	_update_background()

func _update_background():
	_setup_node_from_path("_background", "_background_path", mhBackground, "location_size_changed")
	set_limits(_background.location_size)
#	if is_inside_tree():
#		var bg = get_node(_background_path)
#		if bg is mhBackground:
#			if _background and _background.is_connected("location_size_changed", self, "set_limits"):
#				_background.disconnect("location_size_changed", self, "set_limits")
#			_background = bg
#			_background.connect("location_size_changed", self, "set_limits")
#			set_limits(_background.location_size)

func _setup_node_from_path(node_name, path_name, type_name, signal_name=null):
	if is_inside_tree():
		var node = get_node(path_name)
		if type_name:
			if not node is type_name: return
		if signal_name:
			if get(node_name) and get(node_name).is_connected(signal_name, self, "_on_"+signal_name):
				get(node_name).disconnect(signal_name, self, "_on_"+signal_name)
		get(node_name).set(node)
		if signal_name:
			get(node_name).connect(signal_name, self, "_on_"+signal_name)