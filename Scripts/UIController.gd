extends Node

onready var DebugHeightLabel : RichTextLabel = get_node("GameUI/VBoxContainer/HeightLabel")
onready var DebugMoneyLabel : RichTextLabel = get_node("GameUI/VBoxContainer/MoneyLabel")

func _process(_delta) -> void:
	DebugHeightLabel.text = "Height: " + str(Game.profile.statistics.height) + " / " + str(Game.profile.statistics.height_max)
	DebugMoneyLabel.text = "Money: " + str(Game.profile.statistics.money)
