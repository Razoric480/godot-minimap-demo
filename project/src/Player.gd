extends KinematicBody2D


export var speed := 350.0

var top_left := Vector2.ZERO
var bottom_right := Vector2.ZERO

onready var camera := $Camera2D


func _ready() -> void:
	top_left.x = camera.limit_left
	top_left.y = camera.limit_top
	bottom_right.x = camera.limit_right
	bottom_right.y = camera.limit_bottom
	
	var map_viewport: Viewport = get_tree().root.find_node("Minimap", true, false)
	var icon := MapProxy.new()
	icon.mirror_master = self
	icon.texture = $Head.texture
	icon.region_rect = $Head.region_rect
	icon.region_enabled = true
	icon.scale *= 3.5
	map_viewport.add_child(icon)
	
	var cam_proxy := CamProxy.new()
	cam_proxy.master_cam = $Camera2D
	map_viewport.add_child(cam_proxy)
	cam_proxy.current = true
	cam_proxy.zoom = Vector2(4,4)


func _physics_process(delta: float) -> void:
	var movement := Vector2(
			(-1 if Input.is_key_pressed(KEY_A) else 0 + 1 if Input.is_key_pressed(KEY_D) else 0),
			(-1 if Input.is_key_pressed(KEY_W) else 0 + 1 if Input.is_key_pressed(KEY_S) else 0))
	
	var velocity := movement * speed
	if (
			global_position.x + velocity.x < top_left.x or
			global_position.x + velocity.x > bottom_right.x):
		velocity.x = 0
	
	if (
			global_position.y + velocity.y < top_left.y or
			global_position.y + velocity.y > bottom_right.y):
		velocity.y = 0
	
	move_and_slide(velocity)
