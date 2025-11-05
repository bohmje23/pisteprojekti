extends CharacterBody2D

@export var speed: float = 250
@export var jump_force: float = -900
@export var gravity: float = 1500

var jumps_done: int = 0
@export var max_jumps: int = 2

@onready var camera: Camera2D = get_parent().get_node("Camera2D")
var first_jump_done: bool = false

@onready var sprite: AnimatedSprite2D = $AnimatedSprite2D

func _physics_process(delta: float) -> void:
	if not is_on_floor():
		velocity.y += gravity * delta

	var dir: float = 0.0
	if Input.is_action_pressed("move_left"):
		dir -= 1.0
		sprite.flip_h = true
	if Input.is_action_pressed("move_right"):
		dir += 1.0
		sprite.flip_h = false
	velocity.x = dir * speed

	if Input.is_action_just_pressed("jump"):
		if is_on_floor() or jumps_done < max_jumps:
			velocity.y = jump_force
			jumps_done += 1
			if not first_jump_done:
				camera.start_scrolling()
				first_jump_done = true

	move_and_slide()

	if is_on_floor():
		jumps_done = 0

	if dir != 0:
		sprite.play("move")
	else:
		sprite.stop()
