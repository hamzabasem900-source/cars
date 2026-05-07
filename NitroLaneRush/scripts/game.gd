extends Node2D

@export var enemy_scene: PackedScene
@export var nitro_item_scene: PackedScene

var score: int = 0
var distance: float = 0.0
var lives: int = 3
var nitro_amount: float = 100.0
var game_speed: float = 1.0
var is_game_over: bool = false

@onready var hud = $HUD
@onready var spawn_timer = $SpawnTimer
@onready var player = $Player

func _ready():
	randomize()
	update_hud()
	# Start background music
	# AudioManager.play_music("gameplay")

func _process(delta):
	if is_game_over:
		return
		
	var current_speed = 100.0 * game_speed
	if player.nitro_active and nitro_amount > 0:
		current_speed *= 2.0
		nitro_amount -= 20.0 * delta
		if nitro_amount <= 0:
			player.toggle_nitro(false)
	else:
		nitro_amount = min(nitro_amount + 2.0 * delta, 100.0)
		
	distance += current_speed * delta * 0.1
	score = int(distance * 10)
	
	update_hud()
	
	if distance >= 3000:
		win_game()

func update_hud():
	hud.update_score(score)
	hud.update_distance(distance)
	hud.update_lives(lives)
	hud.update_nitro(nitro_amount)

func _on_spawn_timer_timeout():
	spawn_enemy()

func spawn_enemy():
	var enemy = enemy_scene.instantiate()
	var lane = randi() % 3
	enemy.position = Vector2(player.lanes_x[lane], -100)
	enemy.speed = 400.0 * game_speed
	add_child(enemy)

func _on_player_hit():
	lives -= 1
	# Screen shake
	# Camera.shake()
	if lives <= 0:
		game_over()
	update_hud()

func game_over():
	is_game_over = true
	get_tree().change_scene_to_file("res://scenes/GameOver.tscn")

func win_game():
	is_game_over = true
	get_tree().change_scene_to_file("res://scenes/WinScreen.tscn")
