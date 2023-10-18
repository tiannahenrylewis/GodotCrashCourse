extends AudioStreamPlayer


# Called when the node enters the scene tree for the first time.
func _ready():
	finished.connect(on_finished)
	$Timer.timeout.connect(on_timer_timeout)
	


func on_finished():
	$Timer.start()


func on_timer_timeout():
	play()
