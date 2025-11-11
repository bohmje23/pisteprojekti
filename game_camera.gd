extends Camera2D

@export var scroll_speed: float = 200
@export var max_scroll_speed: float = 600
@export var speed_increase_rate: float = 5.0  # how fast difficulty scales

var scrolling: bool = false
var final_time: float = 0.0
var time_elapsed: float = 0.0

@onready var player := get_parent().get_node("Player")
@onready var gameover := get_parent().get_node("CanvasLayer/DeathScreen")
@onready var timer_ui := get_parent().get_node("CanvasLayer/TimerUI")

func start_scrolling():
	if not scrolling:
		scrolling = true
		timer_ui.start()
		time_elapsed = 0.0

func _process(delta: float) -> void:
	if scrolling:
		global_position.y -= scroll_speed * delta
		time_elapsed += delta
		_update_difficulty(delta)
	_check_player_out_of_bounds()

func _update_difficulty(delta: float) -> void:
	# Gradually increase scroll speed over time, capped at max_scroll_speed
	scroll_speed = min(scroll_speed + speed_increase_rate * delta, max_scroll_speed)

func _check_player_out_of_bounds() -> void:
	var bottom_y = global_position.y + get_viewport_rect().size.y / 2
	if player.position.y > bottom_y:
		player_died()

func player_died() -> void:
	scrolling = false
	timer_ui.stop()
	final_time = timer_ui.get_final_time()
	gameover.show_screen(final_time)
