extends Node2D

var speed = -5
var angular_speed = 0.005


func _physics_process(_delta):
	$Path/PathFollow.offset += speed
	$ConcaveObstacle.rotate(angular_speed)
#	$ConcaveObstacle2.rotate(-angular_speed)
#	$ConcaveObstacle3.rotate(angular_speed)
	$ConvexObstacle.rotate(angular_speed)
	$ConvexObstacle2.rotate(-angular_speed)
#	$ConvexObstacle3.rotate(angular_speed)
#	$ConvexObstacle4.rotate(-angular_speed)
