extends Area2D

func _process(_delta):
	get_node("AnimatedSprite2D").play("default")
func _on_body_entered(body):
	if body.name == "Player":
		body.cherries += 1
		
		var tween1 = get_tree().create_tween()
		var tween2 = get_tree().create_tween()

		tween1.tween_property(self, "scale", Vector2(2,2),.2)
		tween2.tween_property(self, "modulate:a", 0,.2)

		tween1.tween_callback(queue_free)


