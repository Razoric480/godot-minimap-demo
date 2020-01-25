extends "Proxy.gd"


var sprite: Sprite


func _ready() -> void:
	if sprite:
		add_child(sprite)
