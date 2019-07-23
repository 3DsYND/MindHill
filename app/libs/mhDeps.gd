tool

class Component:
	var type
	var path
	var node
	var connects = Dictionary()

var _root
var _pre_update
var _post_update
var _components = Dictionary()


func _init(root_node, post_update=null, pre_update=null):
	_root = root_node
	if post_update and _root.has_method(post_update):
		_post_update = post_update
	if pre_update and _root.has_method(pre_update):
		_pre_update = pre_update

func add(name, type=null, path=NodePath()):
	_components[name] = Component.new()
	_components[name].type = type
	_components[name].path = path

func get(name):
	if _components.has(name):
		return _components[name].node
	print_debug("Component ", name, " not found")
	return null

func has(name):
	if _components.has(name):
		return true
	return false

func update(new_paths):
	if not new_paths: return _get_name_path()
	
	var new_components = Array()
	var checked_components = Dictionary()
	for name in new_paths.keys():
		if not name: continue
		if not _components.has(name): continue
		var comp = _components[name]
		if not comp:
			printerr("Component ", name, " not registered as dependence.")
			continue
		
		if not new_paths[name]:
			comp.path = NodePath()
			comp.node = null
		if comp.path == new_paths[name]:
			continue
		
		if not _root.has_node(new_paths[name]):
			printerr("Node ", new_paths[name], " does not exist.")
			continue
		var node = _root.get_node(new_paths[name])
		if comp.type and not node is comp.type:
			printerr("Component ", name, " has the wrong type.")
			continue
		
		checked_components[name] = Component.new()
		checked_components[name].type = comp.type
		checked_components[name].path = new_paths[name]
		checked_components[name].node = node
		checked_components[name].connects = comp.connects
	
	if _pre_update:
		_root.call(_pre_update, checked_components.keys())
	
	for name in checked_components.keys():
		var comp = checked_components[name]
		for signal_name in comp.connects.keys():
			var method = comp.connects[signal_name]
			if comp.node and comp.node.is_connected(signal_name, _root, method):
				comp.node.disconnect(signal_name, _root, method)
		
		_components[name] = comp
		
		for signal_name in comp.connects.keys():
			var method = comp.connects[signal_name]
			if _check_connection(name, signal_name, method):
				comp.node.connect(signal_name, _root, method)
	
	if _post_update:
		_root.call(_post_update, checked_components.keys())
	return _get_name_path()

func set_connection(name, signal_name, method):
	_components[name].connects[signal_name] = method

func _get_name_path():
	var paths = Dictionary()
	for name in _components.keys():
		paths[name] = _components[name].path
	return paths

func _has_component_signal(name, signal_name):
	for t_signal in _components[name].node.get_signal_list():
		if t_signal["name"] == signal_name: return true
	return false
	
func _check_connection(name, signal_name, method):
	if not _components.has(name):
		printerr("Component ", name, " does not exist")
		return false
	if not _has_component_signal(name, signal_name):
		printerr("Signal ", signal_name, " does not exist")
		return false
	if not _root.has_method(method):
		printerr("Method ", method, " does not exist")
		return false
	return true
