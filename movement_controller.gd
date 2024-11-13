class_name MovementController
extends Node

# Must be placed as the child of the thing you want to move
@export var vertical_freedom: bool = true
@export var horizontal_freedom: bool = true
@export var can_dash: bool = true
@export var dash_factor: float = 5
var target: Node2D
var target_direction: Vector2


func _ready():
	target = get_parent()


func _process(delta):
	if vertical_freedom and Input.is_action_pressed("up"):
		target_direction += Vector2(0, -1)
	if vertical_freedom and Input.is_action_pressed("down"):
		target_direction += Vector2(0, 1)
	if horizontal_freedom and Input.is_action_pressed("left"):
		target_direction += Vector2(-1, 0)
	if horizontal_freedom and Input.is_action_pressed("right"):
		target_direction += Vector2(1, 0)
	target_direction = target_direction.normalized()
	if can_dash and Input.is_action_pressed("dash"):
		target_direction *= dash_factor
	target.position += target_direction * target.data.speed * delta
	target_direction = Vector2.ZERO
