extends Camera2D

@export var scroll_speed: float = 200
var scrolling: bool = false

@onready var player := get_parent().get_node("Player")
@onready var testi_rip := get_parent().get_node("CanvasLayer/TESTI")

func start_scrolling():
	scrolling = true

func _process(delta: float) -> void:
	if scrolling:
		global_position.y -= scroll_speed * delta

	# Player falls off bottom
	var bottom_y = global_position.y + get_viewport_rect().size.y / 2
	if player.position.y > bottom_y:
		player_died()

func player_died() -> void:
	testi_rip.visible = true
	await get_tree().process_frame
	get_tree().paused = true
