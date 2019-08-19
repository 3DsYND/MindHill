tool
extends AnimatedSprite

var deps = preload("res://app/libs/mhDeps.gd").new(self)
export(Dictionary) var dependences setget _set_dependences

func _ready():
	deps.add("controller", mhController)
	deps.set_connection("controller", "run", "_on_runned")
	deps.set_connection("controller", "stop", "_on_stopped")
	dependences = deps.update(dependences)

func _on_runned(arrow):
	if arrow.x > 0:
		flip_h = false
	else:
		flip_h = true
	play("run")

func _on_stopped():
	play("stop")

func _set_dependences(new_dependences):
	dependences = deps.update(new_dependences)