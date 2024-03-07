extends Sprite2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func _process(delta):
	if Input.is_action_pressed("left"):
		# Invert the texture horizontally when the button is pressed
		flip_h = true
	else:
		# Revert the texture when the button is released
		flip_h = false

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
