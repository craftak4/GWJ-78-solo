class_name Eraseble
extends Label

var focused:bool
@onready var rubber:Rubber = get_tree().get_first_node_in_group("rubber")
@export var durability:float
var currentDur:float
@onready var PlrInfo:PlayerInfo = get_tree().root.get_node("PlrInfo")
@onready var LootLocker:LootLockerClass = get_tree().root.get_node("Lootlocker")
var erased:bool = false

func _ready() -> void:
	currentDur = durability
	connect("mouse_entered",func(): focused = true)
	connect("mouse_exited",func(): focused = false)

func _process(delta: float) -> void:
	if erased: return
	PlrInfo.ErasedAll = false
	self_modulate.a = lerpf(self_modulate.a,currentDur/durability,0.25)
	if currentDur <= 0:
		erased = true
		print("erased")
		PlrInfo.Ink += 1
		LootLocker.Returner = func(r): return
		LootLocker.GetRequest("walletCredit").Request(["1"],LootLocker.HttpRequest)

func _input(event: InputEvent) -> void:
	if event is InputEventMouseMotion && focused && Input.is_action_pressed("erase") && !erased:
		currentDur -= abs(((event as InputEventMouseMotion).velocity.x + (event as InputEventMouseMotion).velocity.y)/2) * 0.0001 * rubber.CurrentRubber.Power
