tool
extends Node2D
class_name mhMinigame

signal minigame_started
signal minigame_finished
export(Rect2) var minigame_limits = Rect2(525, 185, 925, 575) setget _set_minigame_limits

func _init():
	add_to_group("minigames")

func _ready():
	connect("visibility_changed", self, "_on_visibility_changed")
	set_process_input(false)

func _on_visibility_changed():
	if visible:
		emit_signal("minigame_started")
		# without this fix, the minigame closes after start
		yield(get_tree().create_timer(0.01), "timeout")
		set_process_input(true)
	else:
		emit_signal("minigame_finished")
		set_process_input(false)

func _set_minigame_limits(limits):
	minigame_limits = limits
	update()

func _draw():
	if Engine.is_editor_hint():
		draw_rect(minigame_limits, Color("#ff0000"), false)

func _input(event):
	if event is InputEventMouseButton:
		if event.is_pressed():
			if (event.position.x < minigame_limits.position.x or
				event.position.y < minigame_limits.position.y or
				event.position.x > minigame_limits.end.x or
				event.position.y > minigame_limits.end.y):
				hide()
