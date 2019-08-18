extends "res://addons/gut/test.gd"

class TestDeps:
	extends "res://addons/gut/test.gd"
	var node = null
	
	
	func before_each():
		node = preload("res://test/node.gd").new()
		add_child(node)
	
	func test_deps_init():
		assert_true(node.deps)
	
	func test_create_empty_depends():
		node.deps.add("img_node")
		node.deps.update(null)
		assert_true(node.deps._components.has("img_node"))
	
	func test_pre_update():
		node.deps.add("img_node")
		node.deps.update({"img_node":""})
		assert_true(node.pre, "_pre_update didn't call")
	
	func test_post_update():
		node.deps.add("img_node")
		node.deps.update({"img_node":""})
		assert_true(node.post, "_post_update didn't call")
	
	func test_add_and_get():
		var depsnode_preload = preload("res://test/node.gd")
		var depsnode = depsnode_preload.new()
		node.add_child(depsnode)
		
		node.deps.add("depsnode", depsnode_preload)
		node.deps.update({"depsnode": depsnode.get_path()})
		assert_eq(node.deps.get("depsnode"), depsnode)
	
	func test_connects():
		var depsnode_preload = preload("res://test/node.gd")
		var depsnode = depsnode_preload.new()
		node.add_child(depsnode)
		
		node.deps.add("depsnode", depsnode_preload)
		node.deps.set_connection("depsnode", "test_signal", "_slot")
		node.deps.update({"depsnode": depsnode.get_path()})
		
		node.deps.get("depsnode").emit_signal("test_signal")
		assert_true(node.slot)