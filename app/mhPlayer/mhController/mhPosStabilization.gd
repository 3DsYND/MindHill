tool
extends Node2D
class_name mhPosStabilization

var deps = preload("res://app/libs/mhDeps.gd").new(self)
export(Dictionary) var dependences setget _set_dependences

const DEGREE_PREC = PI/180
var is_stabilization = false
var vector = null


func _set_dependences(new_dependences):
	dependences = deps.update(new_dependences)

func _ready():
	deps.add("controller", mhController)
	deps.set_connection("controller", "run", "_runned")
	deps.set_connection("controller", "stop", "_stopped")
	dependences = deps.update(dependences)

func _runned(new_vector):
	vector = new_vector

func _stopped():
	if not _is_stable():
		is_stabilization = true
		deps.get("controller").set_run(vector)
		set_physics_process(true)

func _physics_process(delta):
	if not _is_stable():
		return
	set_physics_process(false)
	deps.get("controller").set_run(Vector2(0, 0))

func _is_stable():
	var rotation = deps.get("controller").get_rotation()
	while(rotation > PI/2-DEGREE_PREC/2): 
		rotation -= PI/2
	while(rotation < -PI/2+DEGREE_PREC/2): 
		rotation += PI/2
	
	if abs(rotation) < DEGREE_PREC:
		return true
	return false
