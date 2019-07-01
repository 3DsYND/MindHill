extends Node2D
class_name mhLocation
var type = "location"

export(Rect2) var location_size = Rect2(0, 0, 1920, 1080) setget set_location_size


func set_location_size(new_size):
	location_size = new_size