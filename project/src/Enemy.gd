extends KinematicBody2D


export var speed := 350.0
export var max_distance_from_player := 200.0

onready var player: Node2D = get_tree().get_nodes_in_group("Player")[0]


func _ready() -> void:
	var map_viewport: Viewport = get_tree().get_nodes_in_group("Map")[0]
	map_viewport.add_sprite_clone(self, $Head, 3.5)


func _physics_process(delta: float) -> void:
	var player_pos := player.global_position
	var pos := global_position
	var to_player := (player_pos - pos)
	
	var distance := to_player.length()
	if distance > max_distance_from_player:
		var velocity := to_player.normalized() * speed
		move_and_slide(velocity)
