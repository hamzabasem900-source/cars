extends Control

@onready var final_score_label = $FinalScore
@onready var distance_label = $Distance

func _ready():
	# In a real game, you'd pass these values via a Global singleton
	# final_score_label.text = "Final Score: " + str(Global.last_score)
	pass

func _on_retry_button_pressed():
	get_tree().change_scene_to_file("res://scenes/Game.tscn")

func _on_menu_button_pressed():
	get_tree().change_scene_to_file("res://scenes/MainMenu.tscn")
