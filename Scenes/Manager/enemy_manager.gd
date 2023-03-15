extends Node

const SPAWN_RADIUS = 375

@export var basic_enemy_scn: PackedScene


# Called when the node enters the scene tree for the first time.
func _ready():
	$Timer.timeout.connect(on_timer_timeout)
	
	
func on_timer_timeout():
	var player = get_tree().get_first_node_in_group("Player")
	#check if player exists
	if player == null:
		return
		
	var random_direction = Vector2.RIGHT.rotated(randf_range(0, TAU))
	var spawn_position = player.global_position + (random_direction * SPAWN_RADIUS)
	
	var enemy = basic_enemy_scn.instantiate()
	get_parent().add_child(enemy)
	enemy.global_position = spawn_position
