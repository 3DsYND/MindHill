tool
extends mhLevel
class_name mhLevelStretch

export(int, "Ignore", "Keep", "Keep width", "Keep height", "Expand") var _stretch = 1
onready var app_size


func get_app_size():
	# Return project size considering stretching on different aspect ratio (Vector2)
	return app_size

func _ready():
	# Setting the scene for different screen proportions
	if not Engine.is_editor_hint():
		var stretch_size = Vector2(1920, 1080)
		match _stretch:
			SceneTree.STRETCH_ASPECT_KEEP_HEIGHT:
				stretch_size.x = 1
			SceneTree.STRETCH_ASPECT_KEEP_WIDTH:
				stretch_size.y = 1
		get_tree().set_screen_stretch(SceneTree.STRETCH_MODE_2D, _stretch, stretch_size)
		
	app_size = _get_app_size()
	get_tree().connect("screen_resized", self, "_on_screen_resized")

func _get_app_size():
	var project_size = Vector2()
	project_size.x = ProjectSettings.get_setting("display/window/size/width")
	project_size.y = ProjectSettings.get_setting("display/window/size/height")
	
	if _stretch in [SceneTree.STRETCH_ASPECT_IGNORE, SceneTree.STRETCH_ASPECT_KEEP]:
		return project_size
	
	var window_size = OS.get_window_size()
	var project_to_window = Vector2(project_size.x / window_size.x, project_size.y / window_size.y)
	match _stretch:
		SceneTree.STRETCH_ASPECT_KEEP_HEIGHT:
			return Vector2(round(project_to_window.y * window_size.x), project_size.y)
		SceneTree.STRETCH_ASPECT_KEEP_WIDTH:
			return Vector2(project_size.x, round(project_to_window.x * window_size.y))
		SceneTree.STRETCH_ASPECT_EXPAND:
			if project_to_window.x == project_to_window.y:
				return project_size
			if project_to_window.x < project_to_window.y:
				return Vector2(round(project_to_window.y * window_size.x), project_size.y)
			return Vector2(project_size.x, round(project_to_window.x * window_size.y))

func _on_screen_resized():
	app_size = _get_app_size()
