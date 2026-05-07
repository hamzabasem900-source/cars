extends Area2D

signal hit
signal nitro_activated(active)

@export var lane_width: float = 120.0
@export var move_speed: float = 10.0
@export var nitro_speed_multiplier: float = 1.5

var current_lane: int = 1 # 0: Left, 1: Middle, 2: Right
var target_x: float = 0.0
var lanes_x: Array = [-120.0, 0.0, 120.0]

var is_invincible: bool = false
var nitro_active: bool = false

func _ready():
	target_x = lanes_x[current_lane]
	position.x = target_x

func _input(event):
	if event.is_action_pressed("move_left"):
		change_lane(-1)
	elif event.is_action_pressed("move_right"):
		change_lane(1)
	
	if event.is_action_pressed("use_nitro"):
		toggle_nitro(true)
	elif event.is_action_released("use_nitro"):
		toggle_nitro(false)

func change_lane(direction: int):
	var new_lane = clamp(current_lane + direction, 0, 2)
	if new_lane != current_lane:
		current_lane = new_lane
		target_x = lanes_x[current_lane]

func toggle_nitro(active: bool):
	nitro_active = active
	nitro_activated.emit(active)

func _process(delta):
	# Smooth movement between lanes
	position.x = lerp(position.x, target_x, move_speed * delta)

func _on_area_entered(area):
	if is_invincible:
		return
	
	if area.is_in_group("enemies"):
		hit.emit()
		start_invincibility()

func start_invincibility():
	is_invincible = true
	# Flash effect
	var tween = create_tween()
	tween.tween_property(self, "modulate:a", 0.5, 0.1)
	tween.tween_property(self, "modulate:a", 1.0, 0.1)
	tween.set_loops(5)
	await tween.finished
	is_invincible = false
