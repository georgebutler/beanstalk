extends Node

const MOVEMENT_SPEED = 7

onready var CameraRig : Spatial = get_node("CameraRig")
onready var initial_position : Vector3 = CameraRig.global_transform.origin

func _process(delta) -> void:
	var destination = initial_position + Vector3(0, Game.profile.statistics.height + 1, 0)
	#CameraRig.global_transform.origin = initial_position + Vector3(0, Game.profile.statistics.height + 1, 0)
	CameraRig.global_transform.origin = CameraRig.global_transform.origin.linear_interpolate(destination, MOVEMENT_SPEED * delta)
