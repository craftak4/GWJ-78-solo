class_name Pause
extends PanelContainer

@onready var LL:LootLockerClass = get_tree().root.get_node("Lootlocker")

func _input(event: InputEvent) -> void:
	if event is InputEventKey:
		if (event as InputEventKey).keycode == KEY_ESCAPE:
			DoPause()

func DoPause():
	show()
	get_tree().paused = true
	Input.mouse_mode = Input.MOUSE_MODE_VISIBLE

func Resume():
	hide()
	get_tree().paused = false
	Input.mouse_mode = Input.MOUSE_MODE_HIDDEN

func Copy():
	DisplayServer.clipboard_set(LL.CurrentID)

func Leaderboard():
	$Leaderboard.Show()
