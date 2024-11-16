class_name StartScreen
extends GameMenu

func _load_game_mode_1():
	SceneManager.load_game_mode(0)


func _load_game_mode_2():
	SceneManager.load_game_mode(1)


func _load_game_mode_3():
	SceneManager.load_game_mode(2)


func _load_credits():
	SceneManager.load_credit_screen()
