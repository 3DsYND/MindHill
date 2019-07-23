tool
extends mhBackground
class_name mhBackgroundStatic

export(Texture) var _texture setget _set_texture
export(Color) var _background_color = Color(0, 0, 0) setget _set_background_color
var sprite = null
var bg_rectangle = null

func _init():
	if has_node("_bg_rectangle"):
		bg_rectangle = get_node("_bg_rectangle")
	else:
		bg_rectangle = ColorRect.new()
		bg_rectangle.name = "_bg_rectangle"
		add_child(bg_rectangle)
	
	if has_node("_sprite"):
		sprite = get_node("_sprite")
	else:
		sprite = Sprite.new()
		sprite.name = "_sprite"
		add_child(sprite)

func _ready():
	connect("location_size_changed", self, "_on_location_size_changed")
	bg_rectangle.color = _background_color
	bg_rectangle.rect_position = location_size.position
	bg_rectangle.rect_size = location_size.size
	sprite.centered = false
	z_index = -1

func _on_location_size_changed(new_size):
	bg_rectangle.rect_position = new_size.position
	bg_rectangle.rect_size = new_size.size

func _set_texture(new_texture):
	_texture = new_texture
	sprite.texture = _texture

func _set_background_color(new_color):
	_background_color = new_color
	bg_rectangle.color = _background_color
