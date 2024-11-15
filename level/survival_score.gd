class_name SurvivalScore
extends Label

var score: float = 0

func _ready():
	Events.game_over.connect(_stop)


func _process(delta):
	score += delta
	text = str(round(score))


func _stop():
	set_process(false) # stops calling _process
