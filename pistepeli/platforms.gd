extends Node2D

@export var platform_scene: PackedScene
@export var min_x: float = 1
@export var max_x: float = 200 
@export var min_gap_y: float = 100
@export var max_gap_y: float = 150
@export var num_initial: int = 12

@onready var player := get_parent().get_node("Player")
@onready var camera := get_parent().get_node("Camera2D")

var highest_y: float

func _ready() -> void:
	if platform_scene == null:
		push_error("Platform scene not assigned!")
		return

	# Initialize first platforms starting from the player's position
	highest_y = player.position.y
	for i in range(num_initial):
		spawn_platform(highest_y)
		highest_y -= randf_range(min_gap_y, max_gap_y)

func _process(delta: float) -> void:
	if platform_scene == null:
		return

	var max_jump_height = (abs(player.jump_force) * abs(player.jump_force)) / (2 * player.gravity)

	# Spawn platforms above the camera
	while highest_y > camera.global_position.y - get_viewport_rect().size.y:
		var y_gap = randf_range(min_gap_y, min(max_gap_y, max_jump_height * 0.9))
		highest_y -= y_gap
		spawn_platform(highest_y)

	# Remove platforms below camera
	for plat in get_children():
		if plat.global_position.y > camera.global_position.y + get_viewport_rect().size.y + 100:
			plat.queue_free()

func spawn_platform(y: float) -> void:
	var plat = platform_scene.instantiate()
	var x = randf_range(min_x, max_x)

	if get_child_count() > 0:
		var last = get_child(get_child_count() - 1)
		if abs(x - last.position.x) < 60:
			x += randf_range(150, 300) * (1 if randf() > 0.5 else -1)
			x = clamp(x, min_x, max_x)

	plat.position = Vector2(x, y)
	add_child(plat)
