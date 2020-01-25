extends Node2D
# Helper access for spawners to keep track of spawned enemies


export var enemy_count_max := 10
export var enemy_scene: PackedScene

var enemy_count := 0
