extends Node

var APlayer:AudioStreamPlayer

func _ready() -> void:
	PreparePlayer()

func PreparePlayer():
	APlayer = AudioStreamPlayer.new()
	add_child(APlayer)
	APlayer.stream = load("res://assets/music/syntax.wav")
	APlayer.connect("finished",Play)
	APlayer.play()

func Play():
	APlayer.stream = load("res://assets/music/syntax.wav")
	APlayer.play()
