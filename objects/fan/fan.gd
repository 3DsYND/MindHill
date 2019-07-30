tool
extends AnimatedSprite

signal fan_started(times)
export(Array, int) var times_to_try = [3, 1, 2]
export(int) var pause_time = 3

onready var deps = preload("res://app/libs/mhDeps.gd").new(self)
export(Dictionary) var dependences setget _set_dependences


func try(times_array, pause):
	while true:
		for times in times_array:
			emit_signal("fan_started", times)
			for i in range(times):
				frame = 0
				play("trying")
				yield(self, "animation_finished")
			yield(get_tree().create_timer(pause), "timeout")

func _set_dependences(new_dependences):
	if not deps:
		dependences = new_dependences
	else:
		dependences = deps.update(new_dependences)

func _ready():
	deps.add("wires_minigame")
	dependences = deps.update(dependences)

func _on_mhButton_action_player_activated():
	deps.get("wires_minigame").show()

func _on_wires_minigame_fan_worked():
	try(times_to_try, pause_time)
