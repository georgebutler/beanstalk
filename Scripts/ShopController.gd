extends Node

func upgrade_maximum() -> void:
	if Game.profile.statistics.money - 10 >= 0:
		Game.profile.statistics.money -= 10
		Game.profile.statistics.height_max += 1

func _on_Button_pressed() -> void:
	upgrade_maximum()
