extends Area2D

signal inner_void_enter;

func ready():
	pass

#func _on_CircleObstacle_body_entered(body):
#	Globals.playerHit = true
#	print("inner void enter")


#func _on_CircleObstacle_body_exited(body):
#	print("inner void exit")


func _on_InnerCircle_body_entered(body):
	Globals.playerHit = true
	print("inner void enter")


func _on_InnerCircle_body_exited(body):
	print("inner void exit")


func _on_OuterCircle_body_entered(body):
	#Globals.playerHit = true
	print("outer void enter")


func _on_OuterCircle_body_exited(body):
	print("outer void exit")
