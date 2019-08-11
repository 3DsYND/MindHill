tool
extends mhBackground
class_name mhBackgroundStatic

export(Texture) var _texture setget _set_texture
var sprite = null

func _init():	
	if has_node("_sprite"):
		sprite = get_node("_sprite")
	else:
		sprite = Sprite.new()
		sprite.name = "_sprite"
		sprite.centered = false
		add_child(sprite)

func _set_texture(new_texture):
	_texture = new_texture
	sprite.texture = _texture

