extends KinematicBody


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var t = 0
var a = 150
var b = 150
var pos
var speed = 0.02
var new_velocity

# Called when the node enters the scene tree for the first time.
func _ready():
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	t += delta * speed
	rotate(Vector3(0, 1, 0), PI/1000)
	transform = transform.orthonormalized()

	# Rotate around origin of sun
	var sun_origin = get_node("../Sun").get_transform().origin
	pos = Vector3(a * cos(-t), 0, b * sin(-t))
	
	pos = pos - sun_origin
	new_velocity = pos - transform.origin
	 
	move_and_slide(new_velocity)
	
