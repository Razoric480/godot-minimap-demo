extends Camera2D
class_name CamProxy


var master_cam: Camera2D


func _process(delta: float) -> void:
	global_position = master_cam.global_position
