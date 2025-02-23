extends HBoxContainer

@onready var music:MusicManager = get_tree().root.get_node("MusicManager")

func _process(delta: float) -> void:
	if music.APlayer.playing != $CheckButton.button_pressed:
		music.APlayer.playing = $CheckButton.button_pressed
