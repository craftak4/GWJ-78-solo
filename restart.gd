extends Button

@onready var PlrInfo:PlayerInfo = get_tree().root.get_node("PlrInfo")

func Restart(): PlrInfo.Restart()

func _input(event: InputEvent) -> void:
	if event is InputEventKey:
		if (event as InputEventKey).keycode == KEY_R:
			Restart()
