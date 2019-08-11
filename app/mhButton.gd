tool
extends Node2D

class_name mhButton

signal button_clicked
signal button_player_activated
export(Shape2D) var shape setget _update_shape
var area
var collision


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
		area.connect("input_event", self, "_on_button_clicked")
		add_child(area)

func _update_shape(new_shape):
	shape = new_shape
	collision.shape = new_shape

func _on_button_clicked(viewport, event, shape_idx):
	if event is InputEventMouseButton:
		if not event.is_pressed():
			return
		
		emit_signal("button_clicked")
		if area.get_overlapping_bodies():
			emit_signal("button_player_activated")
