extends Control


# utility
func delete_file_with_extension(ext):
	var dir = Directory.new()
	dir.open("user://")
	dir.list_dir_begin()
	
	while true:
		var file = dir.get_next()
		if file == "":
			break
		elif not file.begins_with(".") and file.right((file.length()-ext.length())) == ext:
			dir.remove(file)
			
	dir.list_dir_end()


func _ready():
	var rng = RandomNumberGenerator.new()
	rng.randomize()
	var randx = rng.randf_range(0, 960)
	var randy = rng.randf_range(0, 640)
	
	$Randy.global_position = Vector2(randx, randy)


func _on_Continue_pressed():
	get_tree().change_scene("res://CourseSelect.tscn")


func _on_Reset_pressed():
	$Confirmation.popup()


func _on_Confirmation_confirmed():
	delete_file_with_extension("save")
