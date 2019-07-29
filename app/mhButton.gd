tool
extends Node2D

class_name mhButton

export(Shape2D) var shape setget _update_shape
var area
var collision
var touch

signal action_clicked
signal action_player_activated

func _init():
	if has_node("_aread2d"):
		area = get_node("_aread2d")
		if area.has_node("_collision"):
			collision = area.get_node("_collision")
		else:
			collision = CollisionShape2D.new()
			collision.name = "_collision"
			area.add_child(collision)
	else:
		area = Area2D.new()
		area.name = "_aread2d"
		collision = CollisionShape2D.new()
		collision.name = "_collision"
		area.add_child(collision)
		add_child(area)
	
	if has_node("_touch_button"):
		touch = get_node("_touch_button")
	else:
		touch = TouchScreenButton.new()
		touch.name = "_touch_button"
		touch.connect("pressed", self, "_on_touch_pressed")
		add_child(touch)

func _update_shape(new_shape):
	shape = new_shape
	collision.shape = new_shape
	touch.shape = new_shape

func _on_touch_pressed():
	emit_signal("action_clicked")
	if area.get_overlapping_bodies():
		emit_signal("action_player_activated")
