extends Node

signal grew
signal grew_max

onready var SegmentContainer : Spatial = get_node("SegmentContainer")
onready var CameraController : Node = get_node("CameraController")
onready var ShopController : Node = get_node("ShopController")
onready var UIController : Node = get_node("UIController")
onready var BeanstalkTween : Tween = get_node("Tween")

var profile = Profile.new()
var profile_path = "user://profile.save"

func _unhandled_input(_event) -> void:
	if Input.is_action_just_pressed("click"):
		grow(1)
	elif Input.is_action_just_pressed("sell"):
		sell()
		
	if Input.is_action_just_pressed("save"):
		save_game()
	elif Input.is_action_just_pressed("load"):
		load_game()
		
func save_game() -> void:
	var file = File.new()
	file.open(profile_path, File.WRITE)
	file.store_var(inst2dict(profile), true)
	file.close()
	
func load_game() -> void:
	var file = File.new()
	if file.file_exists(profile_path):
		file.open(profile_path, File.READ)
		profile = dict2inst(file.get_var())
		file.close()
		
func grow(amount : int) -> void:
	if profile.statistics.height < profile.statistics.height_max:
		for i in abs(amount):
			emit_signal("grew")
			if profile.statistics.height + 0.001 > profile.statistics.height_max + 0.001:
				emit_signal("grew_max")
				break
			else:
				profile.statistics.height += 0.001
				var instance = load(profile.statistics.beanstalk).packed_scene.instance()
				SegmentContainer.add_child(instance)
				instance.global_transform.origin = instance.global_transform.origin + Vector3(0, profile.statistics.height, 0)
				#BeanstalkTween.interpolate_property(instance, "translation", instance.global_transform.origin, instance.global_transform.origin + Vector3(0, profile.statistics.height, 0), 0.2, Tween.TRANS_CUBIC, Tween.EASE_OUT)
				#BeanstalkTween.start()

func sell() -> void:
	for child in SegmentContainer.get_children():
		child.queue_free()

	profile.statistics.money += profile.statistics.height
	profile.statistics.height = 0
