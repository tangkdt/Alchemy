extends TextureButton

@export var bitcoins = 0
@export var yen = 0
@export var dollars = 0

var bitCoinLabel 
var yenCount
var dollarCount

# Called when the button is pressed
func _on_pressed():
	var menu = $Panel
	
	# Check if the menu is visible
	if not menu.is_visible():
		# Position the menu relative to the button
		menu.set_position(Vector2(0, size.y))
		
		# Show the menu at the button's position
		menu.show()
	else:
		# If the menu is visible, hide it
		menu.hide()
	
# Add items to the PopupMenu during setup
func _ready():
	var menu = $Panel
	
	#handle all texts
	bitCoinLabel = menu.get_node("BitcoinCount")  # Assuming the label is named "SomeLabel"
	yenCount = menu.get_node("YenCount")
	dollarCount = menu.get_node("DollarCount")
	
	#Create the TextureButton if it's not already in the scene
	#var texture_button = $TextureButton  # Or use TextureButton.new() to create one dynamically
	
	# Change the normal texture
	#texture_button.texture_normal = load("res://sprites/closeButton.png")
	
	# Initially hide the PopupMenu
	menu.hide()
	
func _process(delta):
	bitCoinLabel.text = str(bitcoins)
	yenCount.text = str(yen)
	dollarCount.text = str(dollars)
