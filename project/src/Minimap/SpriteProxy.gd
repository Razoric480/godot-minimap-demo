extends "Proxy.gd"
# Specialized proxy that takes a sprite and adds it as a child for display purposes


var sprite: Sprite


func _ready() -> void:
	if sprite:
		add_child(sprite)
