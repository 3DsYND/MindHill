extends Node2D

#func _ready():
#	set_process_input(false)
	
func _input(event):
	get_tree().set_input_as_handled()
	print("a")