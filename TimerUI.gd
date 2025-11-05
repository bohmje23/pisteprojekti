extends Control

var alive_time: float = 0.0
var running: bool = false

@onready var timer_label = $TimerLabel

func _process(delta):
	if running:
		alive_time += delta
		timer_label.text = "TIME: " + String.num(alive_time, 2)

func start():
	running = true

func stop():
	running = false

func get_final_time() -> float:
	return alive_time
