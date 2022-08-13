extends Node2D

# var speed = 3
var angular_speed = 0.009


func _physics_process(_delta):
	# $Path/PathFollow.offset += speed
	$ConvexObstacle.rotate(angular_speed)
