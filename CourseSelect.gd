extends Control

var three_point_pars = [2, 3, 2, 3, 4, 2, 2, 3, 2, 4, 4, 2, 2, 5, 4, 5, 3, 4]
var four_point_pars = []
var five_point_pars = []
var six_point_pars = []


# utility
func progress():
	var bests = []
	var dir = Directory.new()
	dir.open("user://")
	dir.list_dir_begin()
	var map = dir.get_next()
	
	while true:
		if map == "":
			break 
		elif not map.begins_with(".") and map.right((map.length() - 4)) == "save":
			var file = File.new()
			file.open("user://%s" % [map], File.READ)
			map = map.left(7)
			map = map.right(4)
			bests.append({map: file.get_var()})
		map = dir.get_next()
		
	dir.list_dir_end()
	return(bests)


func star_count(course_num, hole, strokes):
	var count
	
	match course_num:
		3:
			var par = three_point_pars[hole - 1]
			if strokes - par > 0:
				count = 1
			elif strokes - par == 0:
				count = 2
			elif strokes - par < 0:
				count = 3
		4:
			var par = four_point_pars[hole - 1]
			if strokes - par > 0:
				count = 1
			elif strokes - par == 0:
				count = 2
			elif strokes - par < 0:
				count = 3
		5:
			var par = five_point_pars[hole - 1]
			if strokes - par > 0:
				count = 1
			elif strokes - par == 0:
				count = 2
			elif strokes - par < 0:
				count = 3
		6:
			var par = six_point_pars[hole - 1]
			if strokes - par > 0:
				count = 1
			elif strokes - par == 0:
				count = 2
			elif strokes - par < 0:
				count = 3
				
	return(count)


func show_stars(progress):
	for item in progress:
		var key = item.keys()[0]
		var strokes = item.values()[0]
		var course_num = int(key.left(1))
		var hole = int(key.right(1))
		var star = "Courses/%sPoint/%sNine/Progress%s/Star%s"
		var course
		var half
		var first
		
		if hole == 1:
			first = true
		else:
			first = false
		
		if hole < 10:
			half = "Front"
		else:
			half = "Back"
			
		match course_num:
			3:
				course = "Three"
			4:
				course = "Four"
			5:
				course = "Five"
			6:
				course = "Six"
				
		match star_count(course_num, hole, strokes):
			1:
				if first:
					get_node(star % [course, half, "", ""]).show()
				else:
					get_node(star % [course, half, str(hole), ""]).show()
					
			2:
				if first:
					get_node(star % [course, half, "", ""]).show()
					get_node(star % [course, half, "", "2"]).show()
				else:
					get_node(star % [course, half, str(hole), ""]).show()
					get_node(star % [course, half, str(hole), "2"]).show()
			3:
				if first:
					get_node(star % [course, half, "", ""]).show()
					get_node(star % [course, half, "", "2"]).show()
					get_node(star % [course, half, "", "3"]).show()
				else:
					get_node(star % [course, half, str(hole), ""]).show()
					get_node(star % [course, half, str(hole), "2"]).show()
					get_node(star % [course, half, str(hole), "3"]).show()


func _ready():
	show_stars(progress())


# main menu
func _on_Button_pressed():
# warning-ignore:return_value_discarded
	get_tree().change_scene("res://Main.tscn")

# front nine of three-point course
func _on_Map301_pressed():
	get_tree().change_scene("res://ThreePointCourse/map.tscn")


func _on_Map302_pressed():
	get_tree().change_scene("res://ThreePointCourse/map2.tscn")


func _on_Map303_pressed():
	get_tree().change_scene("res://ThreePointCourse/map3.tscn")


func _on_Map304_pressed():
	get_tree().change_scene("res://ThreePointCourse/map4.tscn")


func _on_Map305_pressed():
	get_tree().change_scene("res://ThreePointCourse/map5.tscn")


func _on_Map306_pressed():
	get_tree().change_scene("res://ThreePointCourse/map6.tscn")


func _on_Map307_pressed():
	get_tree().change_scene("res://ThreePointCourse/map7.tscn")


func _on_Map308_pressed():
	get_tree().change_scene("res://ThreePointCourse/map8.tscn")


func _on_Map309_pressed():
	get_tree().change_scene("res://ThreePointCourse/map9.tscn")


# back nine of the three-point course
func _on_Map310_pressed():
	get_tree().change_scene("res://ThreePointCourse/map10.tscn")


func _on_Map311_pressed():
	get_tree().change_scene("res://ThreePointCourse/map11.tscn")


func _on_Map312_pressed():
	get_tree().change_scene("res://ThreePointCourse/map12.tscn")


func _on_Map313_pressed():
	get_tree().change_scene("res://ThreePointCourse/map13.tscn")


func _on_Map314_pressed():
	get_tree().change_scene("res://ThreePointCourse/map14.tscn")


func _on_Map315_pressed():
	get_tree().change_scene("res://ThreePointCourse/map15.tscn")


func _on_Map316_pressed():
	get_tree().change_scene("res://ThreePointCourse/map16.tscn")


func _on_Map317_pressed():
	get_tree().change_scene("res://ThreePointCourse/map17.tscn")


func _on_Map318_pressed():
	get_tree().change_scene("res://ThreePointCourse/map18.tscn")