class_name Leaderboard
extends PanelContainer

@onready var LL:LootLockerClass = get_tree().root.get_node("Lootlocker")
@onready var Temp:PanelContainer = $VBoxContainer/ScrollContainer/VBoxContainer/Temp
@onready var Items:VBoxContainer = $VBoxContainer/ScrollContainer/VBoxContainer

func Show():
	for i in Items.get_children():
		if i.name != "Temp": i.queue_free()
	LL.Returner = func(r):
		for i in r["items"]:
			var item:PanelContainer = Temp.duplicate()
			Items.add_child(item)
			item.show()
			(item.get_node("HBoxContainer/Rank") as Label).text = str(i["rank"])
			(item.get_node("HBoxContainer/Name") as Label).text = i["player"]["name"]
			(item.get_node("HBoxContainer/Time") as Label).text = str(i["score"]) + " s"
	LL.GetRequest("getLeaderboard").Request([],LL.HttpRequest)
	show()

func _on_return_pressed() -> void:
	hide()
