extends Node2D


func _on_quit_pressed():
	get_tree().quit()
	pass


func _on_play_pressed():
	get_tree().change_scene_to_file("res://world.tscn")
	pass # Replace with function body.

func _ready():
	#Utils.saveGame()
	Utils.loadGame()
