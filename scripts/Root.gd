extends Node2D


func _on_Bird_game_over():
	print("game over")
	$Bird.queue_free()
