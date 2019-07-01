tool
extends mhLocation
class_name mhLocationStatic

export(Texture) var _texture setget _set_texture
export(Color) var _background_color = Color(0, 0, 0) setget _set_background_color
var sprite = null
var bg_rectangle = null

func _init():
	bg_rectangle = ColorRect.new()
	bg_rectangle.color = _background_color
	bg_rectangle.rect_position = location_size.position
	bg_rectangle.rect_size = location_size.size
	add_child(bg_rectangle)
	
	sprite = Sprite.new()
	sprite.centered = false
	add_child(sprite)

func _set_texture(new_texture):
	_texture = new_texture
	sprite.texture = _texture

func _set_background_color(new_color):
	_background_color = new_color
	bg_rectangle.color = _background_color

func set_location_size(new_size):
	location_size = new_size
	bg_rectangle.rect_position = location_size.position
	bg_rectangle.rect_size = location_size.size