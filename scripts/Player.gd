extends CharacterBody2D

signal enter_void
signal exit_void

@export var move_speed = 1000
@export var accel = 5000
var friction = accel / move_speed

var i = 0
var star_round = preload("res://RoundStar.tscn")
var star_direction = Vector2.ZERO
@export var star_speed = 1100
@export var star_volume = 10
@export var star_dispersion_amplitude = 3000


func _ready():
	randomize()
	#get_node("CircleObstacle").connect("inner_void_enter", self, "perish")
	
func _process(delta):
	apply_traction(delta)
	apply_friction(delta)
	
	if (Globals.playerHit):
		Globals.playerHit = false
		perish()
	
func _physics_process(delta):
	move_and_collide(velocity*delta)
	#var motion = Vector2()
	
	#if Input.is_action_pressed("up"):
	#	motion.y -= 1
	#if Input.is_action_pressed("down"):
	#	motion.y += 1
	#if Input.is_action_pressed("right"):
	#	motion.x += 1
	#if Input.is_action_pressed("left"):
	#	motion.x -= 1

	#motion = motion.normalized()
	#motion = move_and_slide(motion * move_speed)
	
	
func apply_traction(delta):
	var traction = Vector2()
	
	if Input.is_action_pressed("up"):
		traction.y -= 1
	if Input.is_action_pressed("down"):
		traction.y += 1
	if Input.is_action_pressed("right"):
		traction.x += 1
	if Input.is_action_pressed("left"):
		traction.x -= 1
	
	traction = traction.normalized()
	
	velocity += traction * accel * delta
	
	i += 1
	if Input.is_action_pressed("LMB") && i > star_volume:
		i = 0
		shoot_stars()
	
func apply_friction(delta):
	velocity -= velocity * friction * delta
	
func shoot_stars():
	var star_instance = star_round.instantiate()
	star_instance.position = get_global_position()
	#star_instance.apply_impulse(Vector2(), Vector2(star_speed,0))
	#star_instance.move_and_slide(Vector2() * star_speed * 0.1)
	star_direction = get_global_mouse_position()
	var star_dispersion_x = (randi() % 10 - 5) * star_dispersion_amplitude / star_direction.x
	var star_dispersion_y = (randi() % 10 - 5) * star_dispersion_amplitude / star_direction.y
	star_instance.velocity = global_position.direction_to(star_direction + Vector2(star_dispersion_x,star_dispersion_y)) * star_speed
	get_tree().get_root().call_deferred("add_child", star_instance)
	
	
func perish():
	get_tree().reload_current_scene()


func _on_Area2D_body_entered(body):
	emit_signal("enter_void")
	if "CircleObstacle" in body.name:
		print("hit")
		#perish()


func _on_Player_body_exited(body):
	emit_signal("exit_void")
	print("exit")
