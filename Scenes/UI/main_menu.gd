extends CanvasLayer


# Called when the node enters the scene tree for the first time.
func _ready():
	$%PlayButton.pressed.connect(on_play_pressed)
	$%OptionsButton.pressed.connect(on_options_pressed)
	$%QuitButton.pressed.connect(on_quit_pressed)


func on_play_pressed():
	get_tree().change_scene_to_file("res://Scenes/Main/main.tscn")


func on_options_pressed():
	pass


func on_quit_pressed():
	get_tree().quit()
