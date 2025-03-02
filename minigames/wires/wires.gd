tool
extends mhMinigame

signal fan_worked()
export(bool) var is_sc_restart = false
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
	if not is_sc_restart: return
	selected_wire = 0
	for wire in range(connected_wire.size()):
		if connected_wire[wire] == false:
			continue
		connected_wire[wire] = false
		get_node("wires/off_"+String(wire+1)).show()
		get_node("wires/on_"+String(wire+1)).hide()

func check_work():
	if not connected_wire.has(false):
		hide()
		emit_signal("fan_worked")

func _on_buttons_input_event(viewport, event, shape_idx):
	if event is InputEventMouseButton:
		if not event.is_pressed():
			return
		if shape_idx < 6:
			# is slot
			connect_wire(selected_wire, shape_idx+1)
			check_work()
		else:
			# is wire
			selected_wire = shape_idx - 5
