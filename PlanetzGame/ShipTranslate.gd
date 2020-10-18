extends KinematicBody

var velocity = Vector3(0,2,0)
var speed = 1.0
var angle = PI/100
var max_speed = 16.0
var target = Vector3(0,0,0)
var last_key = "none"
var dir = Vector3()
var cam_xform
var start_time

func _ready():
	#velocity = -0.01 * self.transform.origin
	cam_xform = get_node("ShipCamera").get_global_transform()
	dir = -cam_xform.basis[2]
	velocity = speed * dir
	

func rot(axis, rad):
	rotate_object_local(axis,rad)
	velocity = velocity.rotated(axis,rad)

func get_input():
	if Input.is_action_just_pressed("quit"):
		get_tree().quit()
	if Input.is_action_pressed("ui_up"):
		rot(Vector3(1,0,0),angle)
		last_key = "ui_up"
	if Input.is_action_pressed("ui_down"):
		rot(Vector3(1,0,0),-angle)
		last_key = "ui_down"
	if Input.is_action_pressed("ui_left"):
		rot(Vector3(0,0,1), -angle)
		last_key = "ui_left"
	if Input.is_action_pressed("ui_right"):
		rot(Vector3(0,0,1), angle)
		last_key = "ui_right"
	if Input.is_action_pressed("roll_left"):
		rot(Vector3(0,1,0), angle)
		last_key = "roll_left"
	if Input.is_action_pressed("roll_right"):
		rot(Vector3(0,1,0), -angle)
		last_key = "roll_right"
	if Input.is_action_pressed("break"):
		velocity *= 0.5
		last_key = "break"
	if last_key == "earth" or Input.is_action_pressed("earth"):
		target = get_node("../Earth").transform.origin
		look_at(target,Vector3(0,1,0))
		rot(Vector3(1,0,0),PI/2)
		var diff = transform.origin - target
		speed = max(max_speed, diff.length())
		last_key = "earth"
		if(diff.length() < 5.0):
			speed = get_node("../Earth").new_velocity.length()
	
	if last_key == "moon" or Input.is_action_pressed("moon"):
		target = get_node("../Moon").transform.origin
		look_at(target,Vector3(0,1,0))
		rot(Vector3(1,0,0),PI/2)
		var diff = target - transform.origin
		speed = max(max_speed, diff.length())
		last_key = "moon"
		if(diff.length() < 5.0):
			speed = get_node("../Moon").new_velocity.length()
	
	if last_key == "mars" or Input.is_action_pressed("mars"):
		target = get_node("../Mars").transform.origin
		look_at(target,Vector3(0,1,0))
		rot(Vector3(1,0,0),PI/2)
		var diff = target - transform.origin
		speed = max(max_speed, diff.length())
		last_key = "mars"
		if(diff.length() < 7.0):
			speed = get_node("../Mars").new_velocity.length()
	
	if last_key == "sun" or Input.is_action_pressed("sun"):
		target = get_node("../Sun").transform.origin
		look_at(target,Vector3(0,1,0))
		rot(Vector3(1,0,0),PI/2)
		var diff = target - transform.origin
		speed = max(max_speed, diff.length())
		last_key = "sun"
		if(diff.length() < 100.0):
			speed = 0.0
			
	if last_key == "mercury" or Input.is_action_pressed("mercury"):
		target = get_node("../Mercury").transform.origin
		look_at(target,Vector3(0,1,0))
		rot(Vector3(1,0,0),PI/2)
		var diff = target - transform.origin
		speed = max(max_speed, diff.length())
		last_key = "mercury"
		if(diff.length() < 7.0):
			speed = get_node("../Mercury").new_velocity.length()
	
	if last_key == "venus" or Input.is_action_pressed("venus"):
		target = get_node("../Venus").transform.origin
		look_at(target,Vector3(0,1,0))
		rot(Vector3(1,0,0),PI/2)
		var diff = target - transform.origin
		speed = max(max_speed, diff.length())
		last_key = "venus"
		if(diff.length() < 7.0):
			speed = get_node("../Venus").new_velocity.length()
	
	if Input.is_action_pressed("thrust"):
		if(last_key != "thrust"):
			get_node("Burn").play()
		if(speed < 1.0):
			speed = 1.1
		if(speed < max_speed):
			speed *= 1.25
		last_key = "thrust"
	dir = Vector3()
	cam_xform = get_node("ShipCamera").get_global_transform()
	dir = -cam_xform.basis[2]
	velocity = speed * dir

func _physics_process(delta):
	get_input()
	velocity = move_and_slide(velocity)
	speed *= 0.99
	if(speed < 0.1):
		$Fire.visible = false
	else:
		$Fire.visible = true
