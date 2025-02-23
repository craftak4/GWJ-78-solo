class_name Secret
extends Button

@onready var LL:LootLockerClass = get_tree().root.get_node("Lootlocker")
@onready var plrInfo:PlrInfo = get_tree().root.get_node("PlrInfo")
@onready var music:MusicManager = get_tree().root.get_node("MusicManager")

func activate() -> void:
	get_tree().paused = true
	music.APlayer.playing = false
	plrInfo.GameRun = false
	$"../UI/SecretFrame".show()
