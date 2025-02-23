extends Control

@onready var PlrInfo:PlayerInfo = get_tree().root.get_node("PlrInfo")

func _process(delta: float) -> void:
	UpdateTime()
	UpdateInk()

func UpdateTime():
	if PlrInfo.CurrentTime == 0: return
	if str(PlrInfo.CurrentTime).split(".")[1] == null:
		$Timer/Label.text = str(PlrInfo.CurrentTime)
		return
	$Timer/Label.text = str(PlrInfo.CurrentTime).split(".")[0] + "." + str(PlrInfo.CurrentTime).split(".")[1].substr(0,2)

func UpdateInk():
	$Ink/Split/Label.text = str(PlrInfo.Ink)
