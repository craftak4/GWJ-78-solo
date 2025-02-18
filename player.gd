class_name Player
extends CharacterBody2D

const speed:float = 200

func _physics_process(delta: float) -> void:
	var dir:Vector2 = Input.get_vector("left","right","up","down")
	velocity = dir * speed
	move_and_slide()
