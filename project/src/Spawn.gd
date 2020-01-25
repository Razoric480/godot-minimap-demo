extends Sprite
# Spawns a new enemy into the world at a slightly randomized time.
# Especially of note is calling the minimap to add a clone of itself as a spawner


onready var timer := $Timer


func _ready() -> void:
	timer.wait_time -= rand_range(0, 3)
	timer.connect("timeout", self, "_on_Timer_timeout")
	timer.start()
	
	var map_viewport: Viewport = get_tree().get_nodes_in_group("Map")[0]
	map_viewport.add_sprite_clone(self, self, 1)


func _on_Timer_timeout() -> void:
	if owner.enemy_count < owner.enemy_count_max:
		var enemy: Node2D = owner.enemy_scene.instance()
		enemy.global_position = global_position + Vector2.UP.rotated(rand_range(-PI, PI)) * 100
		owner.add_child(enemy)
		owner.enemy_count += 1
	timer.start()
