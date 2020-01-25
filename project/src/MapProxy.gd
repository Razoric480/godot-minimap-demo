extends Sprite
class_name MapProxy


var mirror_master: Node2D


func _process(delta: float) -> void:
	global_position = mirror_master.global_position
