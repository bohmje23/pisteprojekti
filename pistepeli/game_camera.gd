extends Camera2D

@export var scroll_speed: float = 200
var scrolling: bool = false
var final_time: float = 0.0

@onready var player := get_parent().get_node("Player")
@onready var gameover := get_parent().get_node("CanvasLayer/DeathScreen")
@onready var timer_ui := get_parent().get_node("CanvasLayer/TimerUI")

func start_scrolling():
	if not scrolling:
		scrolling = true
		timer_ui.start()

func _process(delta: float) -> void:
	if scrolling:
		global_position.y -= scroll_speed * delta
	_check_player_out_of_bounds()

func _check_player_out_of_bounds() -> void:
	var bottom_y = global_position.y + get_viewport_rect().size.y / 2
	if player.position.y > bottom_y:
		player_died()

func player_died() -> void:
	scrolling = false
	timer_ui.stop()
	final_time = timer_ui.get_final_time()
	gameover.show_screen(final_time)
