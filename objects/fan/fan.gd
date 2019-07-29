extends AnimatedSprite

signal fan_started(times)
export(Array, int) var times_to_try = [3, 1, 2]
export(int) var pause_time = 3

func try(times_array, pause):
	while true:
		for times in times_array:
			emit_signal("fan_started", times)
			for i in range(times):
				frame = 0
				play("trying")
				yield(self, "animation_finished")
			yield(get_tree().create_timer(pause), "timeout")

func _on_mhButton_action_player_activated():
	try(times_to_try, pause_time)
