extends Node2D
# Base class for all proxies - simply updating their position to their master template's
# own position


var mirror_master: Node2D


func _process(delta: float) -> void:
	global_position = mirror_master.global_position
