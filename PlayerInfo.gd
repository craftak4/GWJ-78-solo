class_name PlayerInfo
extends Node

var Ink:int
var CurrentTime:float = 0.0
var ErasedAll:bool = false
var TimeRunning:bool = true
var Restarting:bool = false

var StartedSession = true
var GameRun:bool = false

@onready var Inv:Array[RubberResource] = [
	load("res://tres/RubbersRes/BasicRubber.tres"),
]
@onready var Rubbers:Array[RubberResource] = [
	load("res://tres/RubbersRes/BasicRubber.tres"),
	load("res://tres/RubbersRes/AdvancedRubber.tres"),
	load("res://tres/RubbersRes/SuperRubber.tres"),
]

@onready var LL:Lootlocker = get_tree().root.get_node("Lootlocker")

func _process(delta: float) -> void:
	if !GameRun: return
	if TimeRunning: UpdateTime(delta)
	if ErasedAll && !Restarting && TimeRunning: Done()
	ErasedAll = true

func Done():
	TimeRunning = false
	await LL.HttpRequest.request_completed
	LL.Returner = func(r): return
	LL.GetRequest("submitLeaderboard").Request([str(roundf(CurrentTime))],LL.HttpRequest)

func UpdateTime(delta:float):
	CurrentTime += delta

func Restart():
	Restarting = true
	get_tree().change_scene_to_file("res://main_scene.tscn")
	CurrentTime = 0
	ErasedAll = false
	TimeRunning = true

func LoadFromLootlocker():
	LL.Returner = func(r):
		if (r["balances"] as Array).filter(func(item): return item["currency"]["id"] == LL.InkID).size() == 0: 
			Ink = 0
		else:
			Ink = int((r["balances"] as Array).filter(func(item): return item["currency"]["id"] == LL.InkID)[0]["amount"])
		LL.Returner = func(r): 
			for i in r["inventory"]:
				Inv.append(Rubbers.filter(func(x:RubberResource): return x.AssetID == i["asset"]["id"])[0])
		LL.GetRequest("inv").Request([],LL.HttpRequest)
	LL.GetRequest("walletBalance").Request([],LL.HttpRequest)

func AddItem():
	pass

func RemoveItem():
	pass
