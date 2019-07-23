tool
extends Node
class_name mhController

onready var deps = preload("res://app/libs/mhDeps.gd").new(self, "_post_update_dependences", "_pre_update_dependences")
export(Dictionary) var dependences setget _set_dependences

export(Vector2) var spawn = Vector2(100, 100) setget _set_spawn
export(float) var speed = 110*5
var run = {"up": 0, "down": 0, "right": 0, "left": 0}
var position_node

func _set_dependences(new_dependences):
	if not deps:
		dependences = new_dependences
	else:
		dependences = deps.update(new_dependences)

func _pre_update_dependences(new_components_name=null):
	if deps.get("physics"):
		deps.get("physics").remove(position_node)

func _post_update_dependences(new_components_name=null):
	if deps.get("physics"):
		position_node = deps.get("physics").add_to_location()
		deps.get("physics").set_spawn(position_node, spawn)

func _ready():
	set_physics_process(false)
	
	deps.add("physics", mhPhysics)
	dependences = deps.update(dependences)
	if position_node and not Engine.is_editor_hint():
		set_physics_process(true)

func _input(event):
	if event.is_action_pressed("run_right"):
		run.right = 1
	elif event.is_action_released("run_right"):
		run.right = 0
	elif event.is_action_pressed("run_left"):
		run.left = 1
	elif event.is_action_released("run_left"):
		run.left = 0
	elif event.is_action_pressed("run_up"):
		run.up = 1
	elif event.is_action_released("run_up"):
		run.up = 0
	elif event.is_action_pressed("run_down"):
		run.down = 1
	elif event.is_action_released("run_down"):
		run.down = 0

func _physics_process(delta):
	var vector = Vector2()
	vector.x = run.right - run.left
	vector.y = -(run.up - run.down)
	vector = vector.normalized() * speed * delta
	deps.get("physics").move(position_node, vector)

func get_position():
	return position_node.position

func _set_spawn(new_spawn):
	spawn = new_spawn
	if deps and deps.has("physics"):
		deps.get("physics").set_spawn(position_node, spawn)