extends KinematicBody2D


export var speed := 350.0

onready var player: Node2D = get_tree().get_nodes_in_group("Player")[0]


func _ready() -> void:
	var map_viewport: Viewport = get_tree().root.find_node("Minimap", true, false)
	var icon := MapProxy.new()
	icon.mirror_master = self
	icon.texture = $Head.texture
	icon.region_rect = $Head.region_rect
	icon.region_enabled = true
	icon.scale *= 3.5
	map_viewport.add_child(icon)


func _physics_process(delta: float) -> void:
	var player_pos := player.global_position
	var pos := global_position
	var to_player := (player_pos - pos)
	var distance := to_player.length()
	if distance > 200:
		var velocity := to_player.normalized() * speed
		move_and_slide(velocity)
