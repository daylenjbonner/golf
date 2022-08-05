extends Node2D

var speed = 3
var angular_speed = 0.003


func _physics_process(_delta):
	$Path/PathFollow.offset += -1.5 * speed
	$ConcaveObstacle.rotate(angular_speed)
