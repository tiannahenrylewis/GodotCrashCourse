extends CanvasLayer

@onready var panel_container = $%PanelContainer

func _ready():
	panel_container.pivot_offset = panel_container.size / 2
	
	var tween = create_tween()
	tween.tween_property(panel_container, "scale", Vector2.ZERO, .0)
	
	tween.tween_property(panel_container, "scale", Vector2.ONE, .3)\
	.set_ease(Tween.EASE_OUT).set_trans(Tween.TRANS_BACK)

	get_tree().paused = true
	$%ContinueButton.pressed.connect(on_continue_button_pressed)
	$%QuitButton.pressed.connect(on_quit_button_pressed)


func play_jingle(defeat: bool = false):
	if defeat:
		$DefeatStreamPlayer.play()
	else:
		$VictoryStreamPlayer.play()


func set_defeat():
	$%TitleLabel.text = "Defeat"
	$%DescriptionLabel.text = "You Lost!"
	play_jingle(true)


func set_victory():
	$%TitleLabel.text = "Victory"
	$%DescriptionLabel.text = "You Won!"
	

func on_continue_button_pressed():
	ScreenTransition.transition()
	await ScreenTransition.transitioned_halfway
	get_tree().paused = false
	get_tree().change_scene_to_file("res://Scenes/Main/meta_menu.tscn")
	

func on_quit_button_pressed():
	ScreenTransition.transition_to_scene("res://Scenes/UI/main_menu.tscn")
	await ScreenTransition.transitioned_halfway
	get_tree().paused = false
