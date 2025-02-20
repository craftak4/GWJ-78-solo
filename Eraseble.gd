class_name Eraseble
extends Label

var focused:bool
@onready var rubber:Rubber = get_tree().get_first_node_in_group("rubber")
@export var durability:float
var currentDur:float

func _ready() -> void:
	currentDur = durability/2
	connect("mouse_entered",func(): focused = true)
	connect("mouse_exited",func(): focused = false)

func _process(delta: float) -> void:
	if focused && Input.is_action_pressed("erase"):
		currentDur -= 1
	self_modulate.a = lerpf(self_modulate.a,currentDur/durability,0.25)
	print(focused)
