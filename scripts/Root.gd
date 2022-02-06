extends Node2D


func _on_Bird_game_over():
	get_tree().reload_current_scene()
