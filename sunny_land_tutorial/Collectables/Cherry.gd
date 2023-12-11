extends Area2D

func _process(delta):
	get_node("AnimatedSprite2D").play("Idle")

func _on_body_entered(body):
	"""Collect Cherry"""
	if body.name == "Player":
		Game.Gold += 1
		Utils.saveGame()
		var tween = get_tree().create_tween()
		var tween1 = get_tree().create_tween()
		var tween2 = get_tree().create_tween()
		tween.tween_property(self, "position", position - Vector2(0, 25), .2)
		tween1.tween_property(self, "modulate:a", 0, .2)
		tween2.tween_property(self, "scale", Vector2(3,3), .2)
		tween.tween_callback(queue_free)
