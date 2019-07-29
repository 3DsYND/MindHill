extends Node2D

signal fan_worked()
var connected_wire = [false, false, false, false, false, false]
var selected_wire = 0
onready var flash_player = $flash/AnimationPlayer

func connect_wire(wire, slot):
	if wire != slot:
		short_circuit()
		return
	
	connected_wire[wire-1] = true
	get_node("wires/off_"+String(wire)).hide()
	get_node("wires/on_"+String(wire)).show()

func short_circuit():
	flash_player.play("flash")

func check_work():
	if false:
		emit_signal("fan_worked")
	pass

func _on_slot_released_event(slot):
	connect_wire(selected_wire, slot)
	check_work()

func _on_wire_released_event(wire):
	selected_wire = wire
	print(selected_wire)
