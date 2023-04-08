extends KinematicBody2D

var move_speed = 1000
var accel = 5000
var friction = accel / move_speed
var velocity = Vector2()

var i = 0
var star_speed = 1100
var star_round = preload("res://RoundStar.tscn")
var star_volume = 2
var star_direction = Vector2.ZERO
var star_dispersion_amplitude = 30

func _ready():
	randomize()
	
func _process(delta):
	apply_traction(delta)
	apply_friction(delta)
	
func _physics_process(delta):
	velocity = move_and_slide(velocity)
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
	var star_instance = star_round.instance()
	star_instance.position = get_global_position()
	#star_instance.apply_impulse(Vector2(), Vector2(star_speed,0))
	#star_instance.move_and_slide(Vector2() * star_speed * 0.1)
	star_direction = get_global_mouse_position()
	var star_dispersion_x = (randi() % 10 - 5) * star_dispersion_amplitude
	var star_dispersion_y = (randi() % 10 - 5) * star_dispersion_amplitude
	star_instance.velocity = global_position.direction_to(star_direction + Vector2(star_dispersion_x,star_dispersion_y)) * star_speed
	get_tree().get_root().call_deferred("add_child", star_instance)
	
