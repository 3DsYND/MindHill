tool
extends Sprite

onready var deps = preload("res://app/libs/mhDeps.gd").new(self)
export(Dictionary) var dependences setget _set_dependences


func _set_dependences(new_dependences):
	if not deps:
		dependences = new_dependences
	else:
		dependences = deps.update(new_dependences)

func _ready():
	deps.add("tv_minigame")
	dependences = deps.update(dependences)

func _on_mhButton_action_player_activated():
	deps.get("tv_minigame").show()
