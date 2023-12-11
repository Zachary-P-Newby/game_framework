extends Node2D

@onready var window = get_node("Window")

func _on_quit_pressed():
	"""End Game"""
	get_tree().quit()


func _on_how_to_play_pressed():
	"""Show How to play instructions"""
	window.position.x = 384
	pass # Replace with function body.



func _on_window_close_requested():
	window.position.x = 1384


func _on_easy_pressed():
	get_tree().change_scene_to_file("res://level_1.tscn")


func _on_medium_pressed():
	get_tree().change_scene_to_file("res://level_2.tscn")


func _on_hard_pressed():
	get_tree().change_scene_to_file("res://level_3.tscn")
