tool
extends mhLocatioinPath
class_name mhLocatioinPathRectagle

export(int) var corner_radius = 100 setget _set_corner_radius


func _ready():
	set_curve(build_rectangle_curve(game_area, corner_radius))

func build_rectangle_curve(game_area, corner_radius):
	var tl = game_area.position
	var br = game_area.end
	var tr = Vector2(br.x, tl.y)
	var bl = Vector2(tl.x, br.y)
	var rx = corner_radius * Vector2(1,0)
	var ry = corner_radius * Vector2(0,1)
	
	var corners = [bl, br, tr, tl]
	var offsets = [[-ry,rx], [-rx,-ry], [ry,-rx], [rx,ry]]
	
	var curve = Curve2D.new()
	for i in range(corners.size()):
		curve.add_point(corners[i] + offsets[i][0], Vector2(0,0), -offsets[i][0])
		curve.add_point(corners[i] + offsets[i][1])
	curve.add_point(corners[0] + offsets[0][0])
	return curve

func _set_game_area(new_area):
	game_area = new_area
	set_curve(build_rectangle_curve(game_area, corner_radius))
	
func _set_corner_radius(new_radius):
	corner_radius = new_radius
	set_curve(build_rectangle_curve(game_area, corner_radius))