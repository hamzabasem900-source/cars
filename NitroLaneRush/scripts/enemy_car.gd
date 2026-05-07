extends Area2D

@export var speed: float = 400.0
var direction: Vector2 = Vector2.DOWN

func _process(delta):
	position += direction * speed * delta
	
	# Remove if off screen
	if position.y > 1000:
		queue_free()

func _on_visible_on_screen_notifier_2d_screen_exited():
	queue_free()
