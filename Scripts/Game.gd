extends Node

#signal grew
#signal grew_max

onready var CameraController : Node = get_node("CameraController")
onready var ShopController : Node = get_node("ShopController")
onready var UIController : Node = get_node("UIController")

var profile : Profile = Profile.new()
var profile_path = "user://profile.save"

var beanstalk_mesh = null

func _ready():
	# TODO: Load profile
	# TODO: Make sure profile is valid
	profile.apply_settings()
	create_beanstalk_mesh()
		
func create_beanstalk_mesh() -> void:
	if not beanstalk_mesh == null:
		beanstalk_mesh.queue_free()
	beanstalk_mesh = MeshInstance.new()
	beanstalk_mesh.mesh = CylinderMesh.new()
	beanstalk_mesh.mesh.height = max(profile.statistics.height, 0.001) * 2
	beanstalk_mesh.mesh.surface_set_material(0, load(profile.statistics.beanstalk).spatial_material)
	get_tree().get_root().call_deferred("add_child", beanstalk_mesh)
		
func grow(amount : int) -> void:
	if profile.statistics.height < profile.statistics.height_max:
		for i in abs(amount):
			#emit_signal("grew")
			if profile.statistics.height + 0.001 > profile.statistics.height_max + 0.001:
				#emit_signal("grew_max")
				break
			else:
				profile.statistics.height += 0.001
				#beanstalk_mesh.mesh.height = max(profile.statistics.height, 0.001) * 2

func sell() -> void:
	profile.statistics.money += profile.statistics.height
	profile.statistics.height = 0.0
	create_beanstalk_mesh()
	
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
		profile.apply_settings()
