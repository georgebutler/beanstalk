extends Node

func _unhandled_input(_event) -> void:
	if Input.is_action_just_pressed("click"):
		Game.grow(10)
	elif Input.is_action_just_pressed("sell"):
		Game.sell()
		
	if Input.is_action_just_pressed("save"):
		Game.save_game()
	elif Input.is_action_just_pressed("load"):
		Game.load_game()
