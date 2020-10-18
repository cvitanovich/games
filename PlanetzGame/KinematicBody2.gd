extends KinematicBody


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var t = 0


# Called when the node enters the scene tree for the first time.
func _ready():
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	t += 1
	if t % 2 == 0:
		#rotate(Vector3(1, 0, 0), PI/1000)
		rotate(Vector3(0,1,0),PI/1000)
		#rotate(Vector3(0,0,1),PI/1000)
		transform = transform.orthonormalized()

