extends "Proxy.gd"
# Specialized proxy that adds a camera as a child for display purposes


var camera: Camera2D


func _ready() -> void:
	if camera:
		add_child(camera)
