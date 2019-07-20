tool
extends Node2D
class_name mhBackground

export(Rect2) var location_size = Rect2(0, 0, 1920, 1080) setget set_location_size
signal location_size_changed(location_size)


func set_location_size(new_size):
	location_size = new_size
	emit_signal("location_size_changed", location_size)