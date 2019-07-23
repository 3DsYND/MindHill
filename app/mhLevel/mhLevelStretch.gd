tool
extends mhLevel
class_name mhLevelStretch

export(int, "Ignore", "Keep", "Keep width", "Keep height", "Expand") var _stretch = 1

func _ready():
	#Setting the scene for different screen proportions
	if not Engine.is_editor_hint():
		var stretch_size = Vector2(1920, 1080)
		match _stretch:
			SceneTree.STRETCH_ASPECT_KEEP_HEIGHT:
				stretch_size.x = 1
			SceneTree.STRETCH_ASPECT_KEEP_WIDTH:
				stretch_size.y = 1
		get_tree().set_screen_stretch(SceneTree.STRETCH_MODE_2D, _stretch, stretch_size)
