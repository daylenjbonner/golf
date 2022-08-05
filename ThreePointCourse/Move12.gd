extends Node2D

var speed = 6
# var angular_speed = 0.003


func _physics_process(_delta):
	$Path/PathFollow.offset += 0.5 * speed
	$Path2/PathFollow.offset += 1.5 * speed
	$Path3/PathFollow.offset += -speed
	# $ConvexObstacle.rotate(angular_speed)
