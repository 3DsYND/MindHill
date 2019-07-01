extends Node2D

class_name mhLevel

export(int, "Ignore", "Keep", "Keep width", "Keep height", "Expand") var stretch = 1

func _ready():
#	var level_size = utils.get_component("location").level_size
	var stretch_size = Vector2(1920, 1080)
	match stretch:
		SceneTree.STRETCH_ASPECT_KEEP_HEIGHT:
			stretch_size.x = 1
		SceneTree.STRETCH_ASPECT_KEEP_WIDTH:
			stretch_size.y = 1
	get_tree().set_screen_stretch(SceneTree.STRETCH_MODE_2D, stretch, stretch_size)