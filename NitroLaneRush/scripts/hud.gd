extends CanvasLayer

@onready var score_label = $Control/ScoreLabel
@onready var distance_label = $Control/DistanceLabel
@onready var lives_label = $Control/LivesLabel
@onready var nitro_bar = $Control/NitroBar

func update_score(value: int):
	score_label.text = "Score: " + str(value)

func update_distance(value: float):
	distance_label.text = str(int(value)) + "m"

func update_lives(value: int):
	lives_label.text = "Lives: " + str(value)

func update_nitro(value: float):
	nitro_bar.value = value
