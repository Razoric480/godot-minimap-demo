extends "Proxy.gd"


var camera: Camera2D


func _ready() -> void:
	if camera:
		add_child(camera)
