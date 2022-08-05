extends Node2D

# var speed = 4
var angular_speed = 0.006


func _physics_process(_delta):
	# $Path/PathFollow.offset += speed
	$ConvexObstacle.rotate(angular_speed)
