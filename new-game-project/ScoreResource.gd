extends Resource

@export var score : float = 0
@export var highScore : float = 0


func change_score(value : float) -> void:
	score = value
	if score > highScore:
		highScore = score
