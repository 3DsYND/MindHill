tool
extends mhBackground
class_name mhBackgroundStatic

export(Texture) var _texture setget _set_texture
export(Color) var _background_color = Color(0, 0, 0) setget _set_background_color
var sprite = null
var bg_rectangle = null

func _init():
	utils.remove_children(self)
	bg_rectangle = ColorRect.new()
	add_child(bg_rectangle)
	
	sprite = Sprite.new()
	add_child(sprite)

func _ready():
	connect("location_size_changed", self, "_on_location_size_changed")
	bg_rectangle.color = _background_color
	bg_rectangle.rect_position = location_size.position
	bg_rectangle.rect_size = location_size.size
	sprite.centered = false
	z_index = -1

func _on_location_size_changed(new_size):
	bg_rectangle.rect_position = location_size.position
	bg_rectangle.rect_size = location_size.size

func _set_texture(new_texture):
	_texture = new_texture
	sprite.texture = _texture

func _set_background_color(new_color):
	_background_color = new_color
	bg_rectangle.color = _background_color