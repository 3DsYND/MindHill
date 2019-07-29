extends AnimatedSprite


func push(times):
	for i in range(times):
		frame = 0
		play("push")
		yield(self, "animation_finished")
	play("end")
