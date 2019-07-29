extends AnimatedSprite

signal fan_started(times)


func _ready():
	yield(get_tree().create_timer(2), "timeout")
	trying([3, 1, 2], 3)

func trying(times_array, pause=5):
	while true:
		for times in times_array:
			emit_signal("fan_started", times)
			for i in range(times):
				frame = 0
				play("trying")
				yield(self, "animation_finished")
			yield(get_tree().create_timer(pause), "timeout")
