extends Control

@onready var finalscore_label = $FinalScore_Label

var final_time: float = 0.0

func _ready() -> void:
	process_mode = Node.PROCESS_MODE_ALWAYS
	visible = false

func show_screen(time_value: float) -> void:
	final_time = time_value
	finalscore_label.text = "Your score: " + String.num(final_time, 2)
	visible = true

func _on_try_again_button_pressed():
	get_tree().paused = false
	get_tree().change_scene_to_file("res://game.tscn")

func _on_menu_button_pressed():
	get_tree().paused = false
	get_tree().change_scene_to_file("res://main_menu.tscn")

func _on_save_score_button_pressed():
	print("Score saved:", final_time)
