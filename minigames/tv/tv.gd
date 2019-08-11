tool
extends mhMinigame

signal blot_finded
export(int, 0, 999) var aim_canal = 232
export(int, 0, 999) var default_canal = 0 setget _set_canal
var current_canal = [0, 0, 0]
onready var canal_node = get_node("screen/canal")
onready var canal_timer_node = get_node("screen/canal_timer")
onready var blot_node = get_node("blot")


func set_current_canal(digits):
	current_canal = digits
	if not canal_node:
		return
	
	if blot_node and not blot_node.visible:
		var cur_number_canal = current_canal[0] * 100 + current_canal[1] * 10 + current_canal[2] 
		if aim_canal == cur_number_canal:
			blot_node.show()
	
	canal_node.show()
	canal_timer_node.stop()
	for i in range(3):
		get_node("screen/canal/digit_"+String(i)).frame = current_canal[i]
		get_node("switches/switch_"+String(i)).rotation = PI/5*current_canal[i] if current_canal[i] else 0
	canal_timer_node.start(canal_timer_node.wait_time)
	yield(canal_timer_node,"timeout")
	canal_node.hide()

func _ready():
	_set_canal(default_canal)

func _set_canal(v_canal):
	if v_canal < 0 or v_canal > 999:
		return
	default_canal = int(v_canal)
	set_current_canal([default_canal/100, default_canal/10%10, default_canal%10])

func _on_switched(switch):
	var new_canal = current_canal
	if new_canal[switch] != 9:
		new_canal[switch] += 1
	else:
		new_canal[switch] = 0
	set_current_canal(new_canal)


func _on_close_button_released():
	if blot_node.visible:
		emit_signal("blot_finded")
	hide()
