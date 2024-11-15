class_name Lanes
extends Node2D

@export var num_lanes: int = 4
@export var lane_texture: Texture2D = load("res://icon.svg")
@export var lane_size: Vector2 = Vector2(100, 800)
@export var left_boundary: bool = true
@export var right_boundary: bool = true

func _ready():
	for child in get_children():
		child.free()
	var lane_position = Vector2.ZERO
	for i in range(num_lanes):
		_add_lane(lane_position)
		lane_position.x += lane_size.x
	_add_boundaries()


func _add_lane(lane_position):
	var new_lane = Node2D.new()
	
	var sprite = Sprite2D.new()
	sprite.texture = lane_texture
	sprite.scale = lane_size / lane_texture.get_size()
	new_lane.add_child(sprite)
	
	var spawner = Spawner.new()
	spawner.spawn_mode = Spawner.SpawnTimeOption.RandomUniform
	new_lane.add_child(spawner)
	spawner.position.y = -lane_size.y / 2 + 100
	
	add_child(new_lane)
	new_lane.position = lane_position


func _add_boundaries():
	# bottom
	var boundary_position = Vector2(lane_size.x * num_lanes / 2 - lane_size.x / 2, lane_size.y / 2)
	var size = Vector2(lane_size.x * num_lanes, 10)
	_add_boundary(boundary_position, size)
	# top
	boundary_position = Vector2(lane_size.x * num_lanes / 2 - lane_size.x / 2, -lane_size.y / 2)
	_add_boundary(boundary_position, size)
	# right
	size = Vector2(10, lane_size.y)
	if right_boundary:
		boundary_position = Vector2(lane_size.x * num_lanes - lane_size.x / 2, 0)
		_add_boundary(boundary_position, size)
	# left
	if left_boundary:
		boundary_position = Vector2(-lane_size.x / 2, 0)
		_add_boundary(boundary_position, size)


func _add_boundary(boundary_position: Vector2, size: Vector2):
	var area = Area2D.new()
	area.add_child(CollisionShape2D.new())
	var new_shape = RectangleShape2D.new()
	new_shape.size = size
	area.get_child(0).shape = new_shape
	add_child(area)
	area.position = boundary_position
	area.add_to_group("boundary")
