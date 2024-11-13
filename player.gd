class_name Player
extends Entity

func _on_area_entered(area: Area2D):
	Events.game_over.emit()
