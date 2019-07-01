tool
extends Camera2D
class_name mhCamera
var type = "camera"


func _ready():
	anchor_mode = Camera2D.ANCHOR_MODE_FIXED_TOP_LEFT
	current = true

func set_limits(limits):
	limit_top = limits.position.y
	limit_left = limits.position.x
	limit_right = limits.end.x
	limit_bottom = limits.end.y