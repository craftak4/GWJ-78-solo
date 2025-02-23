class_name Inventory
extends PanelContainer

@onready var rubber:Rubber = get_tree().get_first_node_in_group("rubber")
@onready var PlrInfo:PlrInfo = get_tree().root.get_node("PlrInfo")
@onready var LL:LootLockerClass = get_tree().root.get_node("Lootlocker")


@onready var Buttons:Dictionary = {
	0 : $VBoxContainer/GridContainer/Basic,
	745770 : $VBoxContainer/GridContainer/Advanced,
	1 : $VBoxContainer/GridContainer/Super,
}

func _ready() -> void:
	PrepareButtons()

func PrepareButtons():
	$VBoxContainer/GridContainer/Basic.connect("pressed",func(): Process(0))
	$VBoxContainer/GridContainer/Advanced.connect("pressed",func(): Process(745770))
	$VBoxContainer/GridContainer/Super.connect("pressed", func(): Process(1))

func Process(id:int):
	if PlrInfo.Ink < PlrInfo.Rubbers.filter(func(x:RubberResource): return x.AssetID == id)[0].Price: return
	PlrInfo.Ink -= PlrInfo.Rubbers.filter(func(x:RubberResource): return x.AssetID == id)[0].Price
	LL.Returner = func(r): return
	LL.GetRequest("walletDebit").Request([str(PlrInfo.Rubbers.filter(func(x:RubberResource): return x.AssetID == id)[0].Price)],LL.HttpRequest)
	rubber.ChangeRubberResource(PlrInfo.Rubbers.filter(func(x:RubberResource): return x.AssetID == id)[0])
