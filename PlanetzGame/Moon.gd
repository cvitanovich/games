extends KinematicBody


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var t = 0
var a = 20
var b = 20
var pos
var moon_speed = 0.01
var new_velocity


# Called when the node enters the scene tree for the first time.
func _ready():
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	t += delta * moon_speed
	rotate(Vector3(0, 1, 0), PI/1000)
	transform = transform.orthonormalized()

	# Rotate around origin of Earth
	var earth_origin = get_node("../Earth").get_transform().origin
	pos = Vector3(a * cos(t), 0, b * sin(t))
	
	pos = pos + earth_origin
	new_velocity = pos - transform.origin
	new_velocity += get_node("../Earth").new_velocity
	
	new_velocity = move_and_slide(new_velocity)
	
