class_name EntityData
extends Resource

@export var size: Vector2 = Vector2(64, 64) # (x_pixels, y_pixels)
@export var direction: Vector2 = Vector2(0, 1)
@export var speed: float = 100 # pixels per second
@export var texture: Texture2D = load("res://icon.svg")
@export var health: float = 100
