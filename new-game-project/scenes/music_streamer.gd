extends AudioStreamPlayer2D


const tracks = [
	preload("res://assets/music/8Bit - Far Loop (1).wav"),
	preload("res://assets/music/8Bit - Poker Loop (1).wav")
]

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _play_music(music: AudioStream, volume = 0.0):
	if stream == music:
		return
	
	stream = music
	volume_db = volume
	play()

func start_playing_music():
	var song = tracks.pick_random()
	_play_music(song)
	
