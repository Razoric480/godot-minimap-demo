extends KinematicBody2D
# A simple player movement class.
# Of particular note is the player adding one of its sprites as a clone in the minimap,
# and adding the camera as a clone to the minimap to keep track of the player


export var speed := 350.0

var map_top_left := Vector2.ZERO
var map_bottom_right := Vector2.ZERO

onready var camera := $Camera2D


func _ready() -> void:
	map_top_left = Vector2(camera.limit_left, camera.limit_top)
	map_bottom_right = Vector2(camera.limit_right, camera.limit_bottom)
	
	var map_viewport: Viewport = get_tree().get_nodes_in_group("Map")[0]
	map_viewport.add_sprite_clone(self, $Head, 4.5)
	map_viewport.add_camera_clone($Camera2D, 4)


func _physics_process(delta: float) -> void:
	var movement := _get_movement()
	
	var velocity := movement * speed
	
	if (
			global_position.x + velocity.x < map_top_left.x or
			global_position.x + velocity.x > map_bottom_right.x):
		velocity.x = 0
	
	if (
			global_position.y + velocity.y < map_top_left.y or
			global_position.y + velocity.y > map_bottom_right.y):
		velocity.y = 0
	
	move_and_slide(velocity)


func _get_movement() -> Vector2:
	var movement := Vector2(
			Input.get_action_strength("right") - Input.get_action_strength("left"),
			Input.get_action_strength("down") - Input.get_action_strength("up")
	)
	return movement
