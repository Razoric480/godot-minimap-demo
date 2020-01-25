extends Viewport


var SpriteProxy := preload("SpriteProxy.gd")
var CameraProxy := preload("CameraProxy.gd")


func add_sprite_clone(clone_master: Node2D, original_sprite: Sprite, map_scale: float) -> void:
	var sprite_proxy := SpriteProxy.new()
	sprite_proxy.mirror_master = clone_master
	sprite_proxy.global_position = clone_master.global_position
	
	var new_sprite := Sprite.new()
	sprite_proxy.sprite = new_sprite
	
	new_sprite.region_enabled = original_sprite.region_enabled
	new_sprite.region_rect = original_sprite.region_rect
	new_sprite.texture = original_sprite.texture
	new_sprite.scale = Vector2(map_scale, map_scale)
	
	add_child(sprite_proxy)


func add_camera_clone(clone_master: Camera2D, map_zoom: float) -> void:
	for child in get_children():
		if child is CameraProxy:
			printerr("Minimap already contains a camera")
			return
	
	var cam_proxy := CameraProxy.new()
	cam_proxy.mirror_master = clone_master
	cam_proxy.global_position = clone_master.global_position
	
	var new_camera := Camera2D.new()
	new_camera.current = true
	new_camera.zoom = Vector2(map_zoom, map_zoom)
	
	cam_proxy.camera = new_camera
	
	add_child(cam_proxy)
