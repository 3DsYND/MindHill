extends Node2D
class_name mhPlayer
var type = "player"

var location_size = null

func set_location_size(size):
	location_size = size
	var camera = utils.get_component("camera", self)
	if camera and size:
		camera.set_limits(size)
