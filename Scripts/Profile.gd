extends Reference
class_name Profile

export var settings : Dictionary = {
	"use_fxaa": true
}

export var statistics : Dictionary = {
	"money" : 0,
	"height" : 0.0,
	"height_max" : 1.0,
	"growth_increment" : 0.001,
	"beanstalk" : "res://Resources/Beanstalks/Withered.tres"
}

func apply_settings() -> void:
	ProjectSettings.set_setting("rendering/quality/filters/use_fxaa", settings.use_fxaa)
