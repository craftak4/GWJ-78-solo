class_name Rubber
extends Sprite2D

## ABSTRACT CLASS

@export var StartingRubber:RubberResource
@onready var CurrentRubber:RubberResource

func _init() -> void:
	ChangeRubberResource(StartingRubber)

func ChangeRubberResource(new_resource:RubberResource):
	CurrentRubber = new_resource
	texture = CurrentRubber.texture

#var test:int = 1000
#var xVel:float
#@onready var Paper:Panel = get_tree().get_first_node_in_group("Sheet")
#
#func _input(event: InputEvent) -> void:
	##print(str(Paper.global_position) + " " + str(get_global_mouse_position()))
	#if Input.is_action_pressed("erase"):
		#if event is InputEventMouseMotion && ( Paper.global_position.y < get_global_mouse_position().y && Paper.global_position.x < get_global_mouse_position().x) && ( Paper.global_position.y + Paper.size.y  > get_global_mouse_position().y && Paper.global_position.x + Paper.size.x > get_global_mouse_position().x):
			#xVel = abs(((event as InputEventMouseMotion).velocity.x + (event as InputEventMouseMotion).velocity.y)/2) * 0.0035
		#global_position = get_global_mouse_position()
#
#func _on_cooldown_timeout() -> void:
	#test -= xVel
	#print(str(test) + " " + str(xVel))
	#xVel = 0

func FindCurrentEraseble() -> Node:
	return GetEraseble().filter(func(item:Eraseble): return item.Focused)[0]

func GetEraseble() -> Array[Eraseble]:
	return get_tree().get_nodes_in_group("eraseble") as Array[Eraseble]
