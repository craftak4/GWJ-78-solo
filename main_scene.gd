extends Node2D

@onready var PlrInfo:PlayerInfo = get_tree().root.get_node("PlrInfo")
@onready var LL:LootLockerClass = get_tree().root.get_node("Lootlocker")

func _ready() -> void:
	if !PlrInfo.StartedSession: return
	PlrInfo.StartedSession = false
	PlrInfo.GameRun = true
	if !LL.NewAccountSession: PlrInfo.LoadFromLootlocker()
