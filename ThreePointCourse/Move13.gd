extends Node2D

var speed = 4
var angular_speed = 0.004


func _physics_process(_delta):
	$Path/PathFollow.offset += speed
	$ConcaveObstacle.rotate(angular_speed)
	$ConcaveObstacle2.rotate(-angular_speed)
