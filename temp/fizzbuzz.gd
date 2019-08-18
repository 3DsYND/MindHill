extends Node2D

func _ready():
	for i in range(101):
		var res = ""
		if i % 3 == 0:
			res = "Fizz"
		if i % 5 == 0:
			res += "Buzz"
		if not res:
			res = i
		print(res)
