extends Node2D

# Holds the items currently in the container
var items = []

# Signal to notify when a new item is added 
signal item_added(new_item)

# Called when the scene is loaded
func _ready():
	# Connect the Area2D's body_entered signal to handle when items are dropped
	$Area2D.connect("body_entered", Callable(self, "_on_body_entered"))

# Handles items being dropped into the container
func _on_area_2d_body_entered(body: Node2D) -> void:
	# Check if the entering body is an item
	if body.name == "items":  
		$AnimatedSprite2D.modulate = Color(1, 0.8, 0.8)
		items.append(body)  # Add item to container
		emit_signal("item_added", body)  # Notify if needed
		body.queue_free()  # Remove the potion from the scene (optional)
		print("Dust added! Total items:", items.size())
