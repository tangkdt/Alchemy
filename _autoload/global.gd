extends Node

var input_disabled: bool = false
# for activating / killing highlights
var c_to_tweens: Dictionary # {CanvasItem: Tween)

func highlight(c: CanvasItem):
	var tween = get_tree().create_tween()
	c_to_tweens[c] = tween
	tween.bind_node(c)
	tween.set_loops()
	while tween.is_running():
		tween.tween_property(c, "self_modulate:v", 10, 0.5)
		tween.tween_property(c, "self_modulate:v", 1, 0.5)
		await tween.finished


func stop_highlight(c: CanvasItem):
	if c in c_to_tweens:
		c_to_tweens[c].kill()
		c_to_tweens.erase(c)
		c.self_modulate.v = 1
