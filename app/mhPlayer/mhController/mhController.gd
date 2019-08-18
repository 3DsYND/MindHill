tool
extends Node
class_name mhController

var deps = preload("res://app/libs/mhDeps.gd").new(self, "_post_update_dependences", "_pre_update_dependences")
export(Dictionary) var dependences setget _set_dependences

signal run
signal stop
export(Vector2) var spawn = Vector2(100, 100) setget _set_spawn
export(float) var speed = 110*5
var button = {"run_up": 0, "run_down": 0, "run_right": 0, "run_left": 0}
var run = Vector2(0, 0)
var position_node


func set_freeze(freeze):
	set_physics_process(!freeze)

func _set_dependences(new_dependences):
	dependences = deps.update(new_dependences)

func _pre_update_dependences(new_components=null):
	if "physics" in new_components and deps.has("physics"):
		deps.get("physics").remove(position_node)

func _post_update_dependences(new_components=null):
	if "physics" in new_components:
		position_node = deps.get("physics").add_to_location()
		deps.get("physics").set_spawn(position_node, spawn)

func _ready():
	set_physics_process(false)
	
	deps.add("physics", mhPhysics)
	dependences = deps.update(dependences)
	if position_node and not Engine.is_editor_hint():
		set_physics_process(true)
	
	var minigames = get_tree().get_nodes_in_group("minigames")
	for minigame in minigames:
		minigame.connect("minigame_started", self, "set_freeze", [true])
		minigame.connect("minigame_finished", self, "set_freeze", [false])

func _unhandled_input(event):
	for run_arrow in button.keys():
		if event.is_action_pressed(run_arrow):
			button[run_arrow] = 1
			run = Vector2(0, 0)
			emit_signal_input()
			return
		if event.is_action_released(run_arrow):
			button[run_arrow] = 0
			run = Vector2(0, 0)
			emit_signal_input()
			return

func emit_signal_input():
	var vector = _get_buttons_vector()
	if not vector:
		emit_signal("stop")
	else:
		emit_signal("run", vector)

func _physics_process(delta):
	var vector = _get_buttons_vector()
	if run:
		vector += run
	vector = vector.normalized() * speed * delta
	deps.get("physics").move(position_node, vector)

func _get_buttons_vector():
	return Vector2(button["run_right"] - button["run_left"], -(button["run_up"] - button["run_down"]))

func get_position():
	return position_node.position

func get_rotation():
	return position_node.rotation

func set_run(vector):
	run = vector

func _set_spawn(new_spawn):
	spawn = new_spawn
	if deps and deps.has("physics"):
		deps.get("physics").set_spawn(position_node, spawn)