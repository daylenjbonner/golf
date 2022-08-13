extends Node2D

var speed = 3
var angular_speed = 0.008


func _physics_process(_delta):
	$Path/PathFollow.offset += speed
	$Path2/PathFollow.offset += -2 * speed
	$ConcaveObstacle.rotate(angular_speed)
