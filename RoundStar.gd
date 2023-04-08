extends KinematicBody2D

func _ready():
	pass
	
var velocity = Vector2()

func _physics_process(delta):
	velocity = move_and_slide(velocity)
