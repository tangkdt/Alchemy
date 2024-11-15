class_name VictoryZone
extends Node2D

@onready var lanes = %Lanes

func _ready():
	position.y = 0
	position.x = lanes.lane_size.x * lanes.num_lanes + 100
