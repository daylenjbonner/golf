extends Node2D

var speed = 3
# var angular_speed = 0.005


func _physics_process(_delta):
	$Path/PathFollow.offset += speed
	# $ConcaveObstacle.rotate(angular_speed)
	# $ConvexObstacle.rotate(angular_speed)
