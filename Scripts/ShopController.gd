extends Node

func upgrade_maximum() -> void:
	if Game.Profile.statistics.money - 100 >= 0:
		Game.Profile.statistics.money -= 100
		Game.Profile.statistics.height_max += 1

func _on_Button_pressed() -> void:
	upgrade_maximum()
