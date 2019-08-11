tool
extends Node2D
class_name mhMinigame

signal minigame_started
signal minigame_finished


func _init():
	add_to_group("minigames")

func _ready():
	connect("visibility_changed", self, "_on_visibility_changed")

func _on_visibility_changed():
	if visible:
		emit_signal("minigame_started")
	else:
		emit_signal("minigame_finished")
