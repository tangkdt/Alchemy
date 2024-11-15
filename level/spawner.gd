class_name Spawner
extends Node2D

enum SpawnTimeOption {Uniform, RandomUniform, RandomNormal, RandomExponential}
@export var spawn_mode: SpawnTimeOption
@export var mean_time_between_spawn: float = 10 # seconds
@export var min_time_between_spawn: float = 2 # seconds
@export var max_time_between_spawn: float = 10 # seconds
@export var standard_deviation: float = 1 # seconds
@export var entity_data: EntityData = EntityData.new()


func _ready():
	_spawning()


func _spawning():
	while true:
		await get_tree().create_timer(_wait_time()).timeout
		_spawn()


func _spawn():
	var new_entity = Entity.new()
	new_entity.data = entity_data
	add_child(new_entity)
	new_entity.add_to_group("enemy")
	new_entity.area.add_to_group("enemy")


func _wait_time():
	var value = 1000
	match spawn_mode:
		0:
			value = mean_time_between_spawn
		1:
			value = Random.uniform(min_time_between_spawn, max_time_between_spawn)
		2:
			value = Random.normal(mean_time_between_spawn, standard_deviation)
		3:
			value = Random.exponential(mean_time_between_spawn)
	
	return clampf(value, min_time_between_spawn, max_time_between_spawn)
