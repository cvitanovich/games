extends KinematicBody


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var t = 0
var a = 1000
var b = 1100
var pos
var mars_speed = 0.01
var new_velocity

# Called when the node enters the scene tree for the first time.
func _ready():
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	t += delta * mars_speed
	rotate(Vector3(0, 1, 0), PI/1000)
	transform = transform.orthonormalized()


	var mars_origin = get_node("../Sun").get_transform().origin
	pos = Vector3(a * cos(-t), 0, b * sin(-t))
	
	pos = pos - mars_origin
	new_velocity = pos - transform.origin
	 
	move_and_slide(new_velocity)
	
