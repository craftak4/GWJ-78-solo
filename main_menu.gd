extends Control

@onready var ll:LootLockerClass = get_tree().root.get_node("Lootlocker")
@onready var PlrInfo:PlayerInfo = get_tree().root.get_node("PlrInfo")

func play() -> void:
	if $Settings/SettingsElements/LootLocker/LineEdit.text != "":
		$Waiter.show()
		ll.Returner = func(r): 
			if r["player_name"] != "":
				ll.CurrentID = $Settings/SettingsElements/LootLocker/LineEdit.text
				ll.NewAccountSession = false
				ll.CurrentToken = r["session_token"]
				ll.CurrentWalletID = r["wallet_id"]
				print("EXIST!")
				get_tree().change_scene_to_file("res://main_scene.tscn")
			else:	
				print("DONT EXIST!")
				$Waiter.hide()
				$LLName.show()
		ll.GetRequest("registerExisting").Request([$Settings/SettingsElements/LootLocker/LineEdit.text],ll.HttpRequest)
	else:
		$LLName.show()

func submit_lineedit(text:String):
	if !$Waiter.visible: submit()

func submit():
	if $LLName/Elements/Name/LineEdit.text == "": return
	$Waiter.show()
	ll.Returner = func(r):
		ll.CurrentID = r["player_identifier"]
		ll.CurrentToken = r["session_token"]
		ll.CurrentWalletID = r["wallet_id"]
		ll.Returner = func(r):
			get_tree().change_scene_to_file("res://main_scene.tscn")
		ll.GetRequest("changeName").Request([$LLName/Elements/Name/LineEdit.text],ll.HttpRequest)
	ll.GetRequest("registerNew").Request([],ll.HttpRequest)

func settings() -> void: $Settings.show()

func unsubmit():
	$LLName.hide()

func settings_return() -> void: $Settings.hide()
