extends Node2D

var speed = 6
# var angular_speed = 0.004


func _physics_process(_delta):
	$Path/PathFollow.offset += speed
