extends Node2D

var deps = preload("res://app/libs/mhDeps.gd").new(self, "_pre_update_deps", "_post_update_deps")
var pre = false
var post = false
var slot = false
signal test_signal

func _pre_update_deps(new_deps):
	pre = true

func _post_update_deps(new_deps):
	post = true

func _slot():
	slot = true