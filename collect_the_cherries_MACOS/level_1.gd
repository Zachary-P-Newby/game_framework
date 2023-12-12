extends Node2D

@onready var player = get_node("Player/Player")
@onready var countdown = get_node("Countdown")
@onready var display = get_node("Panel/Label")

func _process(_delta):
	
	if player.cherries == 4:
		countdown.stop()
		#countdown.queue_free()
		display.text = "You win!"
		await get_tree().create_timer(1.0).timeout
		get_tree().change_scene_to_file("res://main_menu.tscn")
	else:
		if countdown.time_left > 0:
			display.text = str(int(countdown.time_left))
	


func _on_countdown_timeout():
	display.text = "You lose!"
	await get_tree().create_timer(2.0).timeout
	get_tree().change_scene_to_file("res://main_menu.tscn")
