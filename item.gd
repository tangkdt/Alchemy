extends Control

@export var hi = 0

# Captures input events, called automatically if node experiences anything
var is_dragging = false

func _gui_input(event):
	drag(event)

func drag(event):
	if event is InputEventMouseButton:
		# Check if the left mouse button is clicked
		if event.button_index == MOUSE_BUTTON_LEFT:
			# Held?
			if event.pressed:
				is_dragging = true
				modulate = Color(0.78, 0.78, 0.78) # Change color to red while dragging
			else:
				is_dragging = false
				modulate = Color(1, 1, 1)  # Reset color
				
				 # On mouse release, check if dropped on a valid container
				var container = get_node("../Container")  # Adjust path to the container as needed
				check_and_drop_item(container)
				
	# Change position while dragging
	elif event is InputEventMouseMotion and is_dragging:
		position += event.relative  # Use position to move the node

# Check if the node is dropped in a valid container
func check_and_drop_item(container: Node2D) -> void:
	var texture_rect = container.get_node("TextureRect")
	var container_area = container.get_node("Area2D")

	if texture_rect and container_area and get_global_rect().intersects(Rect2(container.global_position, texture_rect.texture.get_size())):
		if $DropSound:
			$DropSound.play()  # Play sound immediately
		
		# Wait for the sound to finish or timeout after  seconds
		await $DropSound.finished

		queue_free()  # Remove the draggable item from the scene deleting is too slow after sound
