extends Resource

@export var score : float = 0
@export var highScore : float = 0

var mapSpeed

func change_score(value : float) -> void:
	score = snappedf(value * .2, .01)
	if score > highScore:
		highScore = score
	emit_changed()

func change_map_speed(new_speed):
	mapSpeed = new_speed
