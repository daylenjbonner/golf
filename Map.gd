extends Node2D

export (int) var par
export (int) var hole

const stroke_info = "Strokes: %s\nPar: %s\nBest: %s"
const max_bounces = 2
const max_jumps = 2

var rng = RandomNumberGenerator.new()
var ball = "normal"
var positions = [Vector2(64, 64)]
var indicator = false
var strokes = 0
var last_ball_direction
var can_jump = true
var can_bounce = true
var on_water = false
var bounces = 0
var jumps = 0
var restart = false
var best

# ball setup
var _normal_texture = load("res://Assets/Balls/Ball.png")
var _bouncy_texture = load("res://Assets/Balls/Bouncy.png")
var _jumpy_texture = load("res://Assets/Balls/Jumpy.png")
var _randy_texture = load("res://Assets/Balls/Randy.png")
var _skippy_texture = load("res://Assets/Balls/Skippy.png")
var _sticky_texture = load("res://Assets/Balls/Sticky.png")


func ball_setup():
	$ChooseBall.add_icon_item(_normal_texture, "Normal")
	$ChooseBall.add_icon_item(_bouncy_texture, "Bouncy")
	$ChooseBall.add_icon_item(_jumpy_texture, "Jumpy")
	$ChooseBall.add_icon_item(_randy_texture, "Randy")
	$ChooseBall.add_icon_item(_skippy_texture, "Skippy")
	$ChooseBall.add_icon_item(_sticky_texture, "Sticky")


# file utility
func load_best():
	var best_file = "user://best%s.save" % [str(hole)]
	var file = File.new()
	
	if file.file_exists(best_file):
		file.open(best_file, File.READ)
		best = file.get_var()
		file.close()
	else:
		best = 0


func save_best():
	var best_file = "user://best%s.save" % [str(hole)]
	var file = File.new()
	
	file.open(best_file, File.WRITE)
	file.store_var(best)
	file.close()


# utility functions for main loop
func ball_at_rest():
	var rest
	var vel = $Ball.linear_velocity
	
	if  vel.length() < 2:
		rest = true
	else:
		rest = false
		
	return(rest)


func reset_ball():
	var offset = positions[0] - $Ball.position
	$Ball.global_translate(offset)
	$Ball.set_linear_velocity(Vector2(0, 0))
	if not $Ball.visible:
		$Ball.visible = true


func reset_stroke():
	var offset = positions[-1] - $Ball.position
	positions.pop_back()
	$Ball.global_translate(offset)
	$Ball.set_linear_velocity(Vector2(0, 0))
	strokes -= 1
	update_stroke_info()
	if on_water:
		ball = "skippy"
		$Ball/Sprite.texture = _skippy_texture
		$ChooseBall.select(4)


func update_indicator(direction):
	if indicator:
		$Ball/Sprite/Indicator.show()
		$Ball.rotation = direction.angle()
	else:
		$Ball/Sprite/Indicator.hide()


func update_stroke_info():
	$StrokeInfo.text = stroke_info % [strokes, par, best]


func check_ball():
	if ball_at_rest():
		jumps = 0
		bounces = 0
		can_jump = true
		can_bounce = true
		if positions.size() <= strokes:
			positions.append($Ball.position)
		var direction = get_global_mouse_position() - $Ball.position
		if Input.is_action_pressed("cancel_swing") or direction.length() < 15:
			$StrokePower.value = 0
			indicator = false
		elif Input.is_action_just_released("start_stroke"):
			if $StrokePower.value > 100:
				var power = $StrokePower.value * direction.normalized()
				$Ball.apply_central_impulse(power)
				$StrokePower.value = 0
				indicator = false
				strokes += 1
				update_stroke_info()
			else:
				$StrokePower.value = 0
				indicator = false
		elif Input.is_action_pressed("start_stroke") and not $ChooseBall.pressed:
			$StrokePower.value += $StrokePower.step
			indicator = true
		update_indicator(direction)
	else:
		last_ball_direction = $Ball.linear_velocity.normalized()
		match ball:
			"jumpy":
				if can_jump:
					if $Ball.test_motion(last_ball_direction):
						$Ball.translate(65 * last_ball_direction)
						jumps += 1
						if jumps == max_jumps:
							can_jump = false
							ball = "normal"
							$Ball/Sprite.texture = _normal_texture
							$ChooseBall.select(0)
			"randy":
				rng.randomize()
				var rand_mag = 30 * rng.randf_range(-1, 1)
				var rand_ang = rng.randf_range(0, 2 * PI)
				$Ball.apply_central_impulse(rand_mag * Vector2(cos(rand_ang), sin(rand_ang)))
				if rng.randf() < 0.01:
					ball = "normal"
					$Ball/Sprite.texture = _normal_texture
					$ChooseBall.select(0)


func check_on_water():
	if on_water and ball != "skippy":
		reset_stroke()


func check_ball_switch():
	if Input.is_action_just_pressed("normal_ball"):
		ball = "normal"
		$Ball/Sprite.texture = _normal_texture
		$ChooseBall.select(0)
	elif Input.is_action_just_pressed("bouncy_ball"):
		ball = "bouncy"
		$Ball/Sprite.texture = _bouncy_texture
		$ChooseBall.select(1)
	elif Input.is_action_just_pressed("jumpy_ball"):
		ball = "jumpy"
		$Ball/Sprite.texture = _jumpy_texture
		$ChooseBall.select(2)
	elif Input.is_action_just_pressed("randy_ball"):
		ball = "randy"
		$Ball/Sprite.texture = _randy_texture
		$ChooseBall.select(3)
	elif Input.is_action_just_pressed("skippy_ball"):
		ball = "skippy"
		$Ball/Sprite.texture = _skippy_texture
		$ChooseBall.select(4)
	elif Input.is_action_just_pressed("sticky_ball"):
		ball = "sticky"
		$Ball/Sprite.texture = _sticky_texture
		$ChooseBall.select(5)


# at Start
func _ready():
	ball_setup()
	load_best()
	update_stroke_info()


# main loop: every 1/60th second
func _physics_process(_delta):
	check_ball()
	check_on_water()
	check_ball_switch()
	
	if restart:
		reset_ball()
		strokes = 0
		update_stroke_info()
		restart = false


# signals
func _on_Ball_body_entered(_body):
	var hit = str($Ball.get_colliding_bodies().front())
	if hit.begins_with("Mobile"):
		$BounceTimer.start()
	match ball:
		"bouncy":
			if can_bounce and not $Ball.get_colliding_bodies().empty():
				$BounceTimer.start()
				bounces += 1
				if bounces == max_bounces:
					can_bounce = false
					ball = "normal"
					$Ball/Sprite.texture = _normal_texture
					$ChooseBall.select(0)
		"sticky": # How to handle sticking to a moving obstacle?
			$Ball.linear_velocity = Vector2.ZERO


func _on_BounceTimer_timeout():
	if strokes != 0:
		$Ball.apply_central_impulse(200 * last_ball_direction)
		
	$BounceTimer.stop()


func _on_Water_body_entered(body):
	if body == $Ball:
		on_water = true
		if ball != "skippy":
			reset_stroke()
			update_stroke_info()


func _on_Water_body_exited(body):
	if body == $Ball:
		on_water = false


func _on_Grass_body_entered(body):
	if body == $Ball:
		$Ball.linear_damp = 2.4


func _on_Grass_body_exited(body):
	if body == $Ball:
		$Ball.linear_damp = 0.8


func _on_Edges_body_exited(body):
	if body == $Ball:
		can_jump = false


func _on_Edges_body_entered(body):
	if body == $Ball:
		can_jump = true

func _on_Hole_body_entered(body):
	if body == $Ball:
		reset_ball()
		$Ball.hide()
	
	if best == 0 or strokes < best:
		best = strokes
		save_best()


func _on_ChooseBall_item_selected(index):
	match index:
		0:
			ball = "normal"
			$Ball/Sprite.texture = _normal_texture
		1:
			ball = "bouncy"
			$Ball/Sprite.texture = _bouncy_texture
		2:
			ball = "jumpy"
			$Ball/Sprite.texture = _jumpy_texture
		3:
			ball = "randy"
			$Ball/Sprite.texture = _randy_texture
		4:
			ball = "skippy"
			$Ball/Sprite.texture = _skippy_texture
		5:
			ball = "sticky"
			$Ball/Sprite.texture = _sticky_texture


func _on_Restart_pressed():
	restart = true


func _on_Maps_pressed():
	get_tree().change_scene("res://CourseSelect.tscn")
