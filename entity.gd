class_name Entity
extends Node2D


@export var data: EntityData = EntityData.new()
var sprite: Sprite2D
var area: Area2D
var last_position: Vector2


func _ready():
	sprite = Sprite2D.new()
	add_child(sprite)
	sprite.texture = data.texture
	sprite.texture
	area = Area2D.new()
	area.add_child(CollisionShape2D.new())
	add_child(area)
	area.area_entered.connect(_on_area_entered)
	_set_size()


func _process(delta):
	_move(delta)


func _move(delta):
	last_position = position
	position += data.direction * data.speed * delta


func _set_size():
	sprite.scale = data.size / sprite.texture.get_size()
	var new_shape = RectangleShape2D.new()
	new_shape.size = data.size
	area.get_child(0).shape = new_shape


func _on_area_entered(area: Area2D):
	if is_in_group("player"):
		_player_encounters_area(area)
	elif is_in_group("enemy"):
		_enemy_encounters_area(area)


func _player_encounters_area(area: Area2D):
	if area.is_in_group("boundary"):
		_reset_to_last_position()
	if area.is_in_group("enemy"):
		queue_free()
		Events.game_over.emit()
	if area.is_in_group("victory_zone"):
		queue_free()
		Events.victory.emit()


func _enemy_encounters_area(area: Area2D):
	if area.is_in_group("boundary"):
		queue_free()


func _reset_to_last_position():
	position += (last_position - position) * 2
