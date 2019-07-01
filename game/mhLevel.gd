extends Node2D
class_name mhLevel

export(int, "Ignore", "Keep", "Keep width", "Keep height", "Expand") var _stretch = 1


func _ready():
	#Setting the scene for different screen proportions
	var stretch_size = Vector2(1920, 1080)
	match _stretch:
		SceneTree.STRETCH_ASPECT_KEEP_HEIGHT:
			stretch_size.x = 1
		SceneTree.STRETCH_ASPECT_KEEP_WIDTH:
			stretch_size.y = 1
	get_tree().set_screen_stretch(SceneTree.STRETCH_MODE_2D, _stretch, stretch_size)
	
	# Setting player component
	var location = utils.get_component("location")
	var player = utils.get_component("player")
	if player.has_method("set_location_size") and "location_size" in location:
		player.set_location_size(location.location_size)