extends Object
class_name mhProperties
var properties = {}

func add(name, type, default_value):
	properties[name] = {
		"hint": PROPERTY_HINT_NONE,
		"usage": PROPERTY_USAGE_DEFAULT,
		"name": name,
		"type": type,
		"value": default_value 
	}

func get(name):
	if properties.has(name):
		return properties[name].value

func get_property_list():
	return properties.values()

func set(name, value):
	if properties.has(name):
		properties[name].value = value

func _init(list=[]):
	for prop in list:
		add(prop[0], prop[1], prop[2])