extends Button


# Called when the node enters the scene tree for the first time.
func _ready():
	pressed.connect(on_pressed)
	

func on_pressed():
	$RandomStreamPlayerComponent.play_random()
