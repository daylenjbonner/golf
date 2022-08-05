extends Node2D

# var speed = 3
var angular_speed = 0.003


func _physics_process(_delta):
	# $Path/PathFollow.offset += speed
	$ConcaveObstacle.rotate(angular_speed)
	$ConcaveObstacle2.rotate(-1.5 * angular_speed)
	$ConcaveObstacle3.rotate(2 * angular_speed)
